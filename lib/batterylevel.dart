import 'dart:async';

import 'package:flutter/services.dart';

class Batterylevel {
  static const MethodChannel _methodChannel =
      const MethodChannel('batterylevel');

  static const EventChannel _eventChannel = const EventChannel('dice_number');

  static Future<String?> get platformVersion async {
    final String? version =
        await _methodChannel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get batteryLevel async {
    final String? batteryLevel =
        await _methodChannel.invokeMethod('getBatteryLevel');
    return batteryLevel;
  }

  static Stream<int> get getRandomNumberStream {
    return _eventChannel.receiveBroadcastStream().cast();
  }
}
