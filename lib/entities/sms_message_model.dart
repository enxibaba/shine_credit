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

  /// 联系人名称，关联手机通迅录名称
  @JsonKey(name: 'contactName')
  String? contactName;

  @JsonKey(name: 'content')
  String? content;

  /// 短信记录id
  @JsonKey(name: 'msgId')
  int? msgId;

  /// 接收或发送时间
  @JsonKey(name: 'msgTime')
  int? msgTime;

  /// 短信类型 0收到 1发出
  @JsonKey(name: 'msgType')
  int? msgType;

  /// 是否阅读 0未读 1已读
  @JsonKey(name: 'readStatus')
  int? readStatus;

  @JsonKey(name: 'sender')
  String? sender;

  /// 发送状态 -1接受 0完成 64发送中 128失败
  @JsonKey(name: 'status')
  int? status;

  Map<String, dynamic> toJson() => _$SmsMessageModelToJson(this);
}
