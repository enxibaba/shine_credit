
import 'package:flutter/services.dart';

import 'verify_plugin_platform_interface.dart';

class VerifyPlugin {
  Future<String?> detection(bool isAntiHack) {
    return VerifyPluginPlatform.instance.launchDetection(isAntiHack);
  }

  void setMethodCallHandler(
      Future<dynamic> Function(MethodCall call)? handler) {
    VerifyPluginPlatform.instance.setInvokeListener(handler);
  }
}
