import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'verify_plugin_platform_interface.dart';

/// An implementation of [VerifyPluginPlatform] that uses method channels.
class MethodChannelVerifyPlugin extends VerifyPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('verify_plugin');

  @override
  void setInvokeListener(Future<dynamic> Function(MethodCall call)? handler) {
    methodChannel.setMethodCallHandler(handler);
  }

  @override
  Future<String?> launchDetection(bool isAntiHack) {
    return methodChannel.invokeMethod("launchDetection",{
      "antiHack":isAntiHack
    });
  }
}
