import 'package:json_annotation/json_annotation.dart';

part 'nick_model.g.dart';

@JsonSerializable()
class NickModel {
  NickModel(
    this.avatar,
    this.initPwdStatus,
    this.nickname,
  );
  factory NickModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NickModelFromJson(srcJson);

  String? avatar;

  /// 0：未设置   1：已设置
  int? initPwdStatus;

  String? nickname;

  Map<String, dynamic> toJson() => _$NickModelToJson(this);
}
