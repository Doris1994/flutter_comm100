#import "FlutterComm100Plugin.h"
#import "FLNativeView.h"

@implementation FlutterComm100Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_comm100"
            binaryMessenger:[registrar messenger]];
  FLNativeViewFactory* factory = [[FLNativeViewFactory alloc] initWithMessenger:[registrar messenger]];
  [registrar registerViewFactory:factory withId:@"plugins.flutter.io/comm100_view"];
    
  FlutterComm100Plugin* instance = [[FlutterComm100Plugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
