//
//  LivenessLicenseInfo.dart
//
//
//  Created by JSONConverter on 2023/03/13.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'liveness_license_info.g.dart';

@JsonSerializable()
class LivenessLicenseInfo extends Object {
  LivenessLicenseInfo(
    this.expiretimestamp,
    this.license,
  );
  factory LivenessLicenseInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$LivenessLicenseInfoFromJson(srcJson);

  @JsonKey(name: 'expiretimestamp')
  String? expiretimestamp;

  @JsonKey(name: 'license')
  String? license;

  Map<String, dynamic> toJson() => _$LivenessLicenseInfoToJson(this);
}
