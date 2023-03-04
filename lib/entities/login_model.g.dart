// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      json['accessToken'] as String?,
      json['expiresTime'] as num?,
      json['refreshToken'] as String?,
      json['userId'] as num?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresTime': instance.expiresTime,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
    };
