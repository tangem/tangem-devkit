#import "TangemsdkPlugin.h"
#if __has_include(<tangemsdk/tangemsdk-Swift.h>)
#import <tangemsdk/tangemsdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tangemsdk-Swift.h"
#endif

@implementation TangemsdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTangemsdkPlugin registerWithRegistrar:registrar];
}
@end
