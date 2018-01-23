
#import "CDVInsert.h"
@import InsertFramework;

@interface CDVInsert()

@end

@implementation CDVInsert

- (void)pluginInitialize {
}

- (void)setUserAttributes:(CDVInvokedUrlCommand* )command {
    if (command.arguments.count >= 1) {
        [[InsertManager sharedManager]setUserAttributes:command.arguments[0]];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
    }
    else {
        [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"Missing attributes"];
    }
}

- (void)dismissVisibleInserts:(CDVInvokedUrlCommand *)command {
    [[InsertManager sharedManager] dismissVisibleInserts];
    [self sendPluginResult:CDVCommandStatus_OK command:command];
}

- (void)clearVisitor:(CDVInvokedUrlCommand* )command {
        [[InsertManager sharedManager] clearVisitor];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
}

- (void)setVisitor:(CDVInvokedUrlCommand *)command {
    if (command.arguments.count >= 2) {
        NSString *visitorId = command.arguments[0];
        NSString *accountId = command.arguments[1];
        [[InsertManager sharedManager] setVisitor:visitorId accountId:accountId];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
    } else {
        [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"Expecting 2 arguments: visitorId, accountId"];
    }
}

- (void)eventOccurred:(CDVInvokedUrlCommand *)command {
    if (command.arguments.count >= 2) {
        NSString *actionName = command.arguments[0];
        NSDictionary *params = command.arguments[1];
        [[InsertManager sharedManager] eventOccurred:actionName params:params];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
    } else {
        [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"Expecting 2 arguments: actionName, params"];
    }
}

- (void)initSDK:(CDVInvokedUrlCommand *)command {
    NSString *appKey = [self.commandDelegate.settings objectForKey:@"insertappkey"];
    NSString *companyName = [self.commandDelegate.settings objectForKey:@"insertcompanyname"];
    
    if ([appKey length] == 0) {
        return [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"IOS_APP_KEY not defined in config.xml"];
    }
    if ([companyName length] == 0) {
        return [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"COMPANY_NAME not defined in config.xml"];
    }
    
    NSNotificationCenter * __weak notifyCenter = [NSNotificationCenter defaultCenter];
    id __block successToken = [notifyCenter
                        addObserverForName:kIIODidSuccessfullyInitializeSDKNotification
                        object: nil
                        queue: nil
                        usingBlock:^(NSNotification *notifictation) {
                            [notifyCenter removeObserver:successToken];
                            [self sendPluginResult:CDVCommandStatus_OK command:command];
                        }];
    id __block errorToken = [notifyCenter
                        addObserverForName:kIIOErrorInitializeSDKNotification
                        object: nil
                        queue: nil
                        usingBlock:^(NSNotification *notifictation) {
                            [notifyCenter removeObserver:errorToken];
                            [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"Insert.IO init error. No further information was provided by the SDK :("];
                        }];
    NSDictionary *userAttributes;
    NSString *visitorId;
    NSString *accountId;
    if (command.arguments.count >= 3) {
        userAttributes = command.arguments[0];
        visitorId = command.arguments[1];
        accountId = command.arguments[2];
    } else {
        [self sendPluginResult:CDVCommandStatus_OK command:command message:@"Expecting 3 arguments: userAttributes, visitorId, accountId"];
    }
    InsertInitParams *initParams;
    if (userAttributes || visitorId || accountId) {
        initParams = [[InsertInitParams alloc] init];
    }
    if (userAttributes) {
        [initParams setUserAttributes:userAttributes];
    }
    if (visitorId) {
        [initParams setVisitorId:visitorId];
    }
    if (accountId) {
        [initParams setAccountId:accountId];
    }
    [[InsertManager sharedManager] initSDK:appKey companyName:companyName initParams:initParams];
    [self sendPluginResult:CDVCommandStatus_NO_RESULT command:command];
}

- (void)setPushId:(CDVInvokedUrlCommand *)command {
    NSString *pushId;
    if (command.arguments.count >= 1) {
        pushId = command.arguments[0];
    }
    if (pushId) {
        [[InsertManager sharedManager] setPushId:[self restorePushId:pushId]];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
    }
}

/**
 *
 *The method converts PUSHID format from NSString back to NSData
 *
 *The method is used to provide PUSHID to native iOS SDK in correct NSData format. PUSHID was previously converted from NSData to NSString format by native iOS SDK at IIOSetupManager.m:293-296 -(NSString *)getPushId method. JavaScript code at Cordova Insert.js:149 setPushId:function(pushId, success, error) method also explicitly checks for string format of value retrieved. But when it comes to InsertManager.m:1119 setPushId:(NSData *)pushId native iOS method, it needs to be passed in NSData format. For more details, please see Avner's comment at IIOSetupManager.m:293-296 -(NSString *)getPushId native iOS method.
 *
 */

- (NSData *)restorePushId:(NSString *)pushId {
  pushId = [pushId stringByReplacingOccurrencesOfString:@" " withString:@""];
  NSMutableData *pushIdRestored= [[NSMutableData alloc] init];
  unsigned char whole_byte;
  char byte_chars[3] = {'\0','\0','\0'};
  int i;
  for (i = 0; i < [pushId length] / 2; i++) {
    byte_chars[0] = [pushId characterAtIndex:i*2];
    byte_chars[1] = [pushId characterAtIndex:i*2+1];
    whole_byte = strtol(byte_chars, NULL, 16);
    [pushIdRestored appendBytes:&whole_byte length:1];
  }
  
  return pushIdRestored;
}

- (void)sendPluginResult:(CDVCommandStatus)status command:(CDVInvokedUrlCommand*)command {
    [self sendPluginResult:status command:command message:nil];
}

- (void)sendPluginResult:(CDVCommandStatus)status command:(CDVInvokedUrlCommand*)command message:(NSString *)message {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:status messageAsString:message];
    if (status == CDVCommandStatus_NO_RESULT) {
        [result setKeepCallbackAsBool:YES];
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}


- (void)initWithUrl:(CDVInvokedUrlCommand *)command {
    if (command.arguments.count >= 1) {
        NSURL *url = [NSURL URLWithString:command.arguments[0]];
        [[InsertManager sharedManager] initWithUrl:url];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
    }
    else {
        [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"Missing attributes"];
    }
}


@end
