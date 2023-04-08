// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateModel _$UpdateModelFromJson(Map<String, dynamic> json) => UpdateModel(
      json['forceUpdate'] as bool? ?? false,
      json['innerVersion'] as num?,
      json['update'] as bool? ?? false,
      json['updateMsg'] as String?,
      json['updateUrl'] as String?,
      json['version'] as String?,
    );

Map<String, dynamic> _$UpdateModelToJson(UpdateModel instance) =>
    <String, dynamic>{
      'forceUpdate': instance.forceUpdate,
      'innerVersion': instance.innerVersion,
      'update': instance.update,
      'updateMsg': instance.updateMsg,
      'updateUrl': instance.updateUrl,
      'version': instance.version,
    };
