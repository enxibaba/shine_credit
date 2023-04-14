// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsMessageModel _$SmsMessageModelFromJson(Map<String, dynamic> json) =>
    SmsMessageModel(
      json['contactName'] as String?,
      json['content'] as String?,
      json['msgId'] as String?,
      json['msgTime'] as num?,
      json['msgType'] as String?,
      json['readStatus'] as String?,
      json['sender'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$SmsMessageModelToJson(SmsMessageModel instance) =>
    <String, dynamic>{
      'contactName': instance.contactName,
      'content': instance.content,
      'msgId': instance.msgId,
      'msgTime': instance.msgTime,
      'msgType': instance.msgType,
      'readStatus': instance.readStatus,
      'sender': instance.sender,
      'status': instance.status,
    };
