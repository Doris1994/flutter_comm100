#import "FlutterComm100Plugin.h"
#if __has_include(<flutter_comm100/flutter_comm100-Swift.h>)
#import <flutter_comm100/flutter_comm100-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_comm100-Swift.h"
#endif

@implementation FlutterComm100Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterComm100Plugin registerWithRegistrar:registrar];
}
@end
