// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nick_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NickModel _$NickModelFromJson(Map<String, dynamic> json) => NickModel(
      json['avatar'] as String?,
      json['initPwdStatus'] as int?,
      json['nickname'] as String?,
    );

Map<String, dynamic> _$NickModelToJson(NickModel instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'initPwdStatus': instance.initPwdStatus,
      'nickname': instance.nickname,
    };
