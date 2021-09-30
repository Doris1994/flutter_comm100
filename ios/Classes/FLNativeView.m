//
//  FLNativeView.m
//  flutter_comm100
//
//  Created by Doris on 2021/9/29.
//

#import "FLNativeView.h"
#import <VisitorClient/VisitorClientController.h>

@implementation FLNativeViewFactory {
  NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    FLNativeView* viewController = [[FLNativeView alloc] initWithFrame:frame
                                                                         viewIdentifier:viewId
                                                                              arguments:args
                                                                        binaryMessenger:_messenger];
    [viewController makeInitalLoad:args];
  return viewController;
}

@end


@interface CustomClientController : VisitorClientController
{
    NSString *_url;
}
@end

@implementation CustomClientController

-(instancetype)initWithChatUrl:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
    //return [super initWithChatUrl:url];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    WKWebView *webview = (WKWebView *)[self valueForKey:@"_chatWindow"];
    webview.backgroundColor = [UIColor whiteColor];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

@end

@implementation FLNativeView{
    UIView* _view;
    int64_t _viewId;
    VisitorClientController *visitorClient;
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
    _viewId = viewId;
    _view = [[UIView alloc] initWithFrame:frame];
    _view.autoresizesSubviews = true;
    _view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  }
  return self;
}

-(void)makeInitalLoad:(NSDictionary *)param{
    NSString* initialUrl = param[@"url"];
    if ([initialUrl isKindOfClass:[NSString class]]) {
        visitorClient = [[CustomClientController alloc] initWithChatUrl:initialUrl];
        visitorClient.view.frame =_view.bounds;
        visitorClient.view.backgroundColor = [UIColor blueColor];
        visitorClient.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_view addSubview:visitorClient.view];
    }
    
}

- (void)dealloc
{
    
}


- (UIView*)view {
  return _view;
}
@end


