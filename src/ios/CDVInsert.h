
#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>


@interface CDVInsert : CDVPlugin
- (void)dismissVisibleInserts:(CDVInvokedUrlCommand *)command;
- (void)eventOccurred:(CDVInvokedUrlCommand *)command;
@end
