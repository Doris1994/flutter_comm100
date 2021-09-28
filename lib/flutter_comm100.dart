
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterComm100 {
  static const MethodChannel _channel = MethodChannel('flutter_comm100');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
