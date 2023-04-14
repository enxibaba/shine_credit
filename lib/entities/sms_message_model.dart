import 'package:json_annotation/json_annotation.dart';

part 'sms_message_model.g.dart';

@JsonSerializable()
class SmsMessageModel extends Object {
  SmsMessageModel(
    this.contactName,
    this.content,
    this.msgId,
    this.msgTime,
    this.msgType,
    this.readStatus,
    this.sender,
    this.status,
  );
  factory SmsMessageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SmsMessageModelFromJson(srcJson);

  @JsonKey(name: 'contactName')
  String? contactName;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'msgId')
  String? msgId;

  @JsonKey(name: 'msgTime')
  num? msgTime;

  @JsonKey(name: 'msgType')
  String? msgType;

  @JsonKey(name: 'readStatus')
  String? readStatus;

  @JsonKey(name: 'sender')
  String? sender;

  @JsonKey(name: 'status')
  String? status;

  Map<String, dynamic> toJson() => _$SmsMessageModelToJson(this);
}
