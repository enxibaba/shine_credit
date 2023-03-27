// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictionModel _$DictionModelFromJson(Map<String, dynamic> json) => DictionModel(
      json['colorType'] as String?,
      json['remark'] as String?,
      json['dictType'] as String?,
      json['label'] as String?,
      json['value'] as String?,
    );

Map<String, dynamic> _$DictionModelToJson(DictionModel instance) =>
    <String, dynamic>{
      'colorType': instance.colorType,
      'remark': instance.remark,
      'dictType': instance.dictType,
      'label': instance.label,
      'value': instance.value,
    };
