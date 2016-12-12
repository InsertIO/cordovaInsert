
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



@end
