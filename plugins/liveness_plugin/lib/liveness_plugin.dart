// ignore_for_file: unused_import

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

//callback interface
abstract class LivenessDetectionCallback {
  void onGetDetectionResult(bool isSuccess, Map? resultMap);
}

// supported market
enum Market {
  Indonesia,
  India,
  Philippines,
  Vietnam,
  Thailand,
  Malaysia,
  BPS,
  CentralData,
  Mexico,
  Singapore,
  Nigeria,
  Colombia,
  Aksata
}

// supported action
enum DetectionType { MOUTH, BLINK, POS_YAW }

enum DetectionLevel { EASY, NORMAL, HARD }

// plugin
class LivenessPlugin {
  static const MethodChannel _channel = MethodChannel('liveness_plugin');
  static const String platformVersion = '1.0';

  // accessKey&secretKey way to init SDK
  static void initSDK(String accessKey, String secretKey, Market market) {
    String marketStr = market.toString();
    _channel.invokeMethod('initSDK', {
      'accessKey': accessKey,
      'secretKey': secretKey,
      'market':
          marketStr.substring(marketStr.indexOf('.') + 1, marketStr.length),
      'isGlobalService': false
    });
  }

  static void initSDKForGlobalService(
      String accessKey, String secretKey, Market market) {
    String marketStr = market.toString();
    _channel.invokeMethod('initSDK', {
      'accessKey': accessKey,
      'secretKey': secretKey,
      'market':
          marketStr.substring(marketStr.indexOf('.') + 1, marketStr.length),
      'isGlobalService': true
    });
  }

  // license way to init SDK
  static void initSDKOfLicense(Market market) {
    String marketStr = market.toString();
    _channel.invokeMethod('initSDKOfLicense', {
      'market':
          marketStr.substring(marketStr.indexOf('.') + 1, marketStr.length),
      'isGlobalService': false
    });
  }

  static void initSDKOfLicenseForGlobalService(Market market) {
    String marketStr = market.toString();
    _channel.invokeMethod('initSDKOfLicense', {
      'market':
          marketStr.substring(marketStr.indexOf('.') + 1, marketStr.length),
      'isGlobalService': true
    });
  }

  static Future<String?> setLicenseAndCheck(String license) async {
    String? result =
        await _channel.invokeMethod('setLicenseAndCheck', {'license': license});
    return result;
  }

  static void startLivenessDetection(
      LivenessDetectionCallback livenessDetectionCallback) {
    Future<String> livenessCall(MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'init':
          break;
        case 'onDetectionSuccess':
          print('onDetectionSuccess called:$livenessDetectionCallback');
          livenessDetectionCallback.onGetDetectionResult(
              true, methodCall.arguments as Map?);
          break;
        case 'onDetectionFailure':
          livenessDetectionCallback.onGetDetectionResult(
              false, methodCall.arguments as Map?);
          break;
      }
      return '';
    }

    _channel.setMethodCallHandler(livenessCall);
    _channel.invokeMethod('startLivenessDetection');
  }

  static void setActionSequence(
      bool shuffle, List<DetectionType> actionSequence) {
    List<String> actionList = [];
    for (final detectionType in actionSequence) {
      final detectionTypeStr = detectionType.toString();
      actionList.add(detectionTypeStr.substring(
          detectionTypeStr.indexOf('.') + 1, detectionTypeStr.length));
    }
    _channel.invokeMethod('setActionSequence',
        {'shuffle': shuffle, 'actionSequence': actionList});
  }

  static void setDetectionLevel(DetectionLevel detecionLevel) {
    String detecionLevelStr = detecionLevel.toString();
    _channel.invokeMethod('setDetectionLevel', {
      'detectionLevel':
          detecionLevelStr.substring(detecionLevelStr.indexOf('.') + 1)
    });
  }

  static void setDetectOcclusion(bool detectOcclusion) {
    _channel.invokeMethod(
        'setDetectOcclusion', {'detectOcclusion': detectOcclusion});
  }

  static void setCollectImageSequence(bool collectImgSequence) {
    _channel.invokeMethod(
        'setCollectImageSequence', {'collectImgSequence': collectImgSequence});
  }

  static void setActionTimeoutMills(int actionTimeoutMills) {
    _channel.invokeMethod(
        'setActionTimeoutMills', {'actionTimeoutMills': actionTimeoutMills});
  }

  static void setResultPictureSize(int resultPictureSize) {
    _channel.invokeMethod(
        'setResultPictureSize', {'resultPictureSize': resultPictureSize});
  }

  static void bindUser(String userId) {
    _channel.invokeMethod('bindUser', {'userId': userId});
  }

  static Future get getSDKVersion async {
    return await _channel.invokeMethod('getSDKVersion');
  }

  static Future get getLatestDetectionResult async {
    return await _channel.invokeMethod('getLatestDetectionResult');
  }
}
