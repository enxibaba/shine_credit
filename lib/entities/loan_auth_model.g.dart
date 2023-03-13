// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanAuthModel _$LoanAuthModelFromJson(Map<String, dynamic> json) =>
    LoanAuthModel(
      json['apr'] as String?,
      json['loanAmount'] as String?,
      json['tenure'] as String?,
      json['userCertification'] == null
          ? null
          : AuthUserCertification.fromJson(
              json['userCertification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoanAuthModelToJson(LoanAuthModel instance) =>
    <String, dynamic>{
      'apr': instance.apr,
      'loanAmount': instance.loanAmount,
      'tenure': instance.tenure,
      'userCertification': instance.userCertification,
    };

AuthUserCertification _$AuthUserCertificationFromJson(
        Map<String, dynamic> json) =>
    AuthUserCertification(
      json['authentication'] as bool?,
      json['bandCard'] as bool?,
      json['emergencyContact'] as bool?,
      json['faceAuthentication'] as bool?,
    );

Map<String, dynamic> _$AuthUserCertificationToJson(
        AuthUserCertification instance) =>
    <String, dynamic>{
      'authentication': instance.authentication,
      'bandCard': instance.bandCard,
      'emergencyContact': instance.emergencyContact,
      'faceAuthentication': instance.faceAuthentication,
    };
