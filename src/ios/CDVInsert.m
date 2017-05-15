
#import "CDVInsert.h"
#import <InsertFramework/InsertFramework.h>

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

- (void)setUserId:(CDVInvokedUrlCommand* )command {
    if (command.arguments.count < 1) {
        return [self sendPluginResult:CDVCommandStatus_ERROR command:command message:@"Missing user id"];
    }
    [[InsertManager sharedManager]setUserId:command.arguments[0]];
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
    [[InsertManager sharedManager] initSDK:appKey companyName:companyName];
    [self sendPluginResult:CDVCommandStatus_NO_RESULT command:command];
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
