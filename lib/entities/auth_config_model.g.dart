// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthConfigModel _$AuthConfigModelFromJson(Map<String, dynamic> json) =>
    AuthConfigModel(
      json['certificationStatus'] == null
          ? null
          : AuthCertificationStatus.fromJson(
              json['certificationStatus'] as Map<String, dynamic>),
      json['riskDataUploadConfig'] == null
          ? null
          : AuthRiskDataUploadConfig.fromJson(
              json['riskDataUploadConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthConfigModelToJson(AuthConfigModel instance) =>
    <String, dynamic>{
      'certificationStatus': instance.certificationStatus,
      'riskDataUploadConfig': instance.riskDataUploadConfig,
    };

AuthCertificationStatus _$AuthCertificationStatusFromJson(
        Map<String, dynamic> json) =>
    AuthCertificationStatus(
      json['bindingBankCard'] as bool?,
      json['emergencyContact'] as bool?,
      json['livenessDetection'] as bool?,
      json['ocrAuth'] as bool?,
    );

Map<String, dynamic> _$AuthCertificationStatusToJson(
        AuthCertificationStatus instance) =>
    <String, dynamic>{
      'bindingBankCard': instance.bindingBankCard,
      'emergencyContact': instance.emergencyContact,
      'livenessDetection': instance.livenessDetection,
      'ocrAuth': instance.ocrAuth,
    };

AuthRiskDataUploadConfig _$AuthRiskDataUploadConfigFromJson(
        Map<String, dynamic> json) =>
    AuthRiskDataUploadConfig(
      json['appList'] as bool?,
      json['callRecord'] as bool?,
      json['cellMessage'] as bool?,
      json['deviceBaseInfo'] as bool?,
      json['deviceInfo'] as bool?,
      json['imginfo'] as bool?,
      json['linkerBook'] as bool?,
      json['locationInfo'] as bool?,
    );

Map<String, dynamic> _$AuthRiskDataUploadConfigToJson(
        AuthRiskDataUploadConfig instance) =>
    <String, dynamic>{
      'appList': instance.appList,
      'callRecord': instance.callRecord,
      'cellMessage': instance.cellMessage,
      'deviceBaseInfo': instance.deviceBaseInfo,
      'deviceInfo': instance.deviceInfo,
      'imginfo': instance.imginfo,
      'linkerBook': instance.linkerBook,
      'locationInfo': instance.locationInfo,
    };
