
#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>


@interface CDVInsert : CDVPlugin
- (void)initSDK:(CDVInvokedUrlCommand *)command;
- (void)dismissVisibleInserts:(CDVInvokedUrlCommand *)command;
- (void)eventOccurred:(CDVInvokedUrlCommand *)command;
- (void)setUserAttributes:(CDVInvokedUrlCommand* )command;
- (void)setUserId:(CDVInvokedUrlCommand* )command;
@end
