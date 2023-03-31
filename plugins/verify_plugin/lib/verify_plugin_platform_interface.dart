import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'verify_plugin_method_channel.dart';

abstract class VerifyPluginPlatform extends PlatformInterface {
  /// Constructs a VerifyPluginPlatform.
  VerifyPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static VerifyPluginPlatform _instance = MethodChannelVerifyPlugin();

  /// The default instance of [VerifyPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelVerifyPlugin].
  static VerifyPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VerifyPluginPlatform] when
  /// they register themselves.
  static set instance(VerifyPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> launchDetection(bool isAntiHack) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void setInvokeListener(Future<dynamic> Function(MethodCall call)? handler){

  }
}
