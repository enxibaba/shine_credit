//
//  AppInfoModel.dart
//
//
//  Created by JSONConverter on 2023/04/28.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'app_info_model.g.dart';

@JsonSerializable()
class AppInfoModel extends Object {
  AppInfoModel(
    this.apklistName,
    this.appIcon,
    this.appName,
    this.appType,
    this.firstInstallTime,
    this.lastUpdateTime,
    this.packageName,
    this.versionCode,
    this.versionName,
  );
  factory AppInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AppInfoModelFromJson(srcJson);

  @JsonKey(name: 'apklistName')
  String? apklistName;

  @JsonKey(name: 'appIcon')
  String? appIcon;

  @JsonKey(name: 'appName')
  String? appName;

  @JsonKey(name: 'appType')
  num? appType;

  @JsonKey(name: 'firstInstallTime')
  num? firstInstallTime;

  @JsonKey(name: 'lastUpdateTime')
  num? lastUpdateTime;

  @JsonKey(name: 'packageName')
  String? packageName;

  @JsonKey(name: 'versionCode')
  num? versionCode;

  @JsonKey(name: 'versionName')
  String? versionName;

  Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);
}
