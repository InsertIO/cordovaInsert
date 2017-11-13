
#import "CDVInsert.h"
@import InsertFramework;

@interface CDVInsert()

@end

@implementation CDVInsert

- (void)pluginInitialize {
}

- (void)setUserAttributes:(CDVInvokedUrlCommand* )command {
    if (command.arguments.count < 1) {
        return [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"Missing attributes"];
    }
    [[InsertManager sharedManager]setUserAttributes:command.arguments[0]];
    [self sendPluginResult:CDVCommandStatus_OK command:command];
}

- (void)dismissVisibleInserts:(CDVInvokedUrlCommand *)command {
    [[InsertManager sharedManager] dismissVisibleInserts];
    [self sendPluginResult:CDVCommandStatus_OK command:command];
}


- (void)eventOccurred:(CDVInvokedUrlCommand *)command {
    if (command.arguments.count >= 2) {
        NSString *actionName = command.arguments[0];
        NSDictionary *params = command.arguments[1];
        [[InsertManager sharedManager] eventOccurred:actionName params:params];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
    } else {
        [self sendPluginResult:CDVCommandStatus_OK command:command message:@"Expecting 2 arguments: actionName, params"];
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
        [self sendPluginResult:CDVCommandStatus_OK command:command message:@"Expecting 2 arguments: actionName, params"];
    }
    InsertInitParams *initParams = [[InsertInitParams alloc] init];
    if (userAttributes)
        [initParams setUserAttributes:userAttributes];
    if (visitorId)
        [initParams setVisitorId:visitorId];
    if (accountId)
        [initParams setAccountId:accountId];
    [[InsertManager sharedManager] initSDK:appKey companyName:companyName initParams:initParams];
    [self sendPluginResult:CDVCommandStatus_NO_RESULT command:command];
}

- (void)setPushId:(CDVInvokedUrlCommand *)command {
    NSData *pushId;
    if (command.arguments.count >= 1)
        pushId = command.arguments[0];
    if (pushId) {
        [[InsertManager sharedManager] setPushId:pushId];
        [self sendPluginResult:CDVCommandStatus_OK command:command];
    }
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
    NSURL *url = [NSURL URLWithString:command.arguments[0]];
    [[InsertManager sharedManager] initWithUrl:url];
    [self sendPluginResult:CDVCommandStatus_OK command:command];
}


@end
