// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfoModel _$AppInfoModelFromJson(Map<String, dynamic> json) => AppInfoModel(
      json['apklistName'] as String?,
      json['appIcon'] as String?,
      json['appName'] as String?,
      json['appType'] as num?,
      json['firstInstallTime'] as num?,
      json['lastUpdateTime'] as num?,
      json['packageName'] as String?,
      json['versionCode'] as num?,
      json['versionName'] as String?,
    );

Map<String, dynamic> _$AppInfoModelToJson(AppInfoModel instance) =>
    <String, dynamic>{
      'apklistName': instance.apklistName,
      'appIcon': instance.appIcon,
      'appName': instance.appName,
      'appType': instance.appType,
      'firstInstallTime': instance.firstInstallTime,
      'lastUpdateTime': instance.lastUpdateTime,
      'packageName': instance.packageName,
      'versionCode': instance.versionCode,
      'versionName': instance.versionName,
    };
