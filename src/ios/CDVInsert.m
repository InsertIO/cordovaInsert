
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


-(void)eventOccured:(CDVInvokedUrlCommand *)command {
    if (command.arguments.count >= 2) {
        NSString *actionName = [command argumentArIndex:0];
        NSDictionary *params = [command argumentArIndex: 1];
        [InsertManager sharedManager eventOccured:actionName json:params];
        [self sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] to:command.callbackId];
    } else {
        [self sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"invalid arguments"] to:command.callbackId];
}



@end
