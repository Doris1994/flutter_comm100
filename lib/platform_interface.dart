import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show StandardMessageCodec;

abstract class NativeViewPlatform {
  String viewType = 'plugins.flutter.io/comm100_view';

  Widget build({
    required BuildContext context,
    required String url,
  });
}

class CuoertinoCommWidget extends NativeViewPlatform {
  @override
  Widget build({required BuildContext context, required String url}) {
    return UiKitView(
      viewType: viewType,
      onPlatformViewCreated: (int viewId) {},
      creationParams: {'url': url},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

class MaterialCommWidget extends NativeViewPlatform {
  @override
  Widget build({required BuildContext context, required String url}) {
    return AndroidView(
      viewType: viewType,
      onPlatformViewCreated: (viewId) {
        // platforms
        //     .add(MethodChannel('com.flutter.guide.MyFlutterView_$viewId'));
      },
      creationParams: {'url': url},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
