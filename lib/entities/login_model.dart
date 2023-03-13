import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  LoginModel(
    this.accessToken,
    this.expiresTime,
    this.refreshToken,
    this.userId,
  );
  factory LoginModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginModelFromJson(srcJson);

  String? accessToken;

  int? expiresTime;

  String? refreshToken;

  int? userId;

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}