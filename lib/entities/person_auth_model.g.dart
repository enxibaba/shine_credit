// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonAuthModel _$PersonAuthModelFromJson(Map<String, dynamic> json) =>
    PersonAuthModel(
      json['adCardNo'] as String?,
      json['adCardOcrName'] as String?,
      json['birthday'] as String?,
      json['memberAddress'] as String?,
      json['memberPin'] as String?,
      json['panNo'] as String?,
      json['panOcrName'] as String?,
      json['sex'] as String?,
    );

Map<String, dynamic> _$PersonAuthModelToJson(PersonAuthModel instance) =>
    <String, dynamic>{
      'adCardNo': instance.adCardNo,
      'adCardOcrName': instance.adCardOcrName,
      'birthday': instance.birthday,
      'memberAddress': instance.memberAddress,
      'memberPin': instance.memberPin,
      'panNo': instance.panNo,
      'panOcrName': instance.panOcrName,
      'sex': instance.sex,
    };
