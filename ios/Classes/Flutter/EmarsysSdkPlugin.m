#import "EmarsysSdkPlugin.h"
#if __has_include(<emarsys_sdk/emarsys_sdk-Swift.h>)
#import <emarsys_sdk/emarsys_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "emarsys_sdk-Swift.h"
#endif

@implementation EmarsysSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEmarsysSdkPlugin registerWithRegistrar:registrar];
}
@end
