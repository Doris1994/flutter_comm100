import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'platform_interface.dart';

class LiveChatWidget extends StatefulWidget {
  final String url;
  const LiveChatWidget({Key? key, required this.url}) : super(key: key);

  @override
  _LiveChatWidgetState createState() => _LiveChatWidgetState();
}

class _LiveChatWidgetState extends State<LiveChatWidget> {
  NativeViewPlatform? _platform;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: platform.build(context: context, url: widget.url));
  }

  NativeViewPlatform get platform {
    if (_platform == null) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          _platform = MaterialCommWidget();
          break;
        case TargetPlatform.iOS:
          _platform = CuoertinoCommWidget();
          break;
        default:
          throw UnsupportedError(
              "Trying to use the default comm100 view implementation for $defaultTargetPlatform but there isn't a default one");
      }
    }
    return _platform!;
  }
}
