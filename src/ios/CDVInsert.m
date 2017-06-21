
#import "CDVInsert.h"
#import <InsertFramework/InsertFramework.h>

@interface CDVInsert()

@end

@implementation CDVInsert

- (void)dismissVisibleInserts:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    [[InsertManager sharedManager] dismissVisibleInserts];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
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

-(void)eventOccurred:(CDVInvokedUrlCommand *)command {
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    if (command.arguments.count >= 2) {
        NSString *actionName = command.arguments[0];
        NSDictionary *params = command.arguments[1];
        [[InsertManager sharedManager] eventOccurred:actionName parameters:params];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    } else {
        
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



@end
