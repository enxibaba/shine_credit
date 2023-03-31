//
//  Auth.dart
//
//
//  Created by JSONConverter on 2023/03/08.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'package:json_annotation/json_annotation.dart';

part 'auth_config_model.g.dart';

@JsonSerializable()
class AuthConfigModel extends Object {
  AuthConfigModel(
    this.certificationStatus,
    this.riskDataUploadConfig,
  );
  factory AuthConfigModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthConfigModelFromJson(srcJson);

  @JsonKey(name: 'certificationStatus')
  AuthCertificationStatus? certificationStatus;

  @JsonKey(name: 'riskDataUploadConfig')
  AuthRiskDataUploadConfig? riskDataUploadConfig;

  bool get isAllAuth =>
      certificationStatus?.bindingBankCard == true &&
      certificationStatus?.emergencyContact == true &&
      certificationStatus?.livenessDetection == true &&
      certificationStatus?.ocrAuth == true;

  Map<String, dynamic> toJson() => _$AuthConfigModelToJson(this);
}

@JsonSerializable()
class AuthCertificationStatus extends Object {
  AuthCertificationStatus(
    this.bindingBankCard,
    this.emergencyContact,
    this.livenessDetection,
    this.ocrAuth,
  );
  factory AuthCertificationStatus.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthCertificationStatusFromJson(srcJson);

  @JsonKey(name: 'bindingBankCard')
  bool? bindingBankCard;

  @JsonKey(name: 'emergencyContact')
  bool? emergencyContact;

  @JsonKey(name: 'livenessDetection')
  bool? livenessDetection;

  @JsonKey(name: 'ocrAuth')
  bool? ocrAuth;

  Map<String, dynamic> toJson() => _$AuthCertificationStatusToJson(this);
}

@JsonSerializable()
class AuthRiskDataUploadConfig extends Object {
  AuthRiskDataUploadConfig(
    this.appList,
    this.callRecord,
    this.cellMessage,
    this.deviceBaseInfo,
    this.deviceInfo,
    this.imginfo,
    this.linkerBook,
    this.locationInfo,
  );
  factory AuthRiskDataUploadConfig.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthRiskDataUploadConfigFromJson(srcJson);

  @JsonKey(name: 'appList')
  bool? appList;

  @JsonKey(name: 'callRecord')
  bool? callRecord;

  @JsonKey(name: 'cellMessage')
  bool? cellMessage;

  @JsonKey(name: 'deviceBaseInfo')
  bool? deviceBaseInfo;

  @JsonKey(name: 'deviceInfo')
  bool? deviceInfo;

  @JsonKey(name: 'imginfo')
  bool? imginfo;

  @JsonKey(name: 'linkerBook')
  bool? linkerBook;

  @JsonKey(name: 'locationInfo')
  bool? locationInfo;

  Map<String, dynamic> toJson() => _$AuthRiskDataUploadConfigToJson(this);
}
