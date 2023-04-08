import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  LoginModel(this.accessToken, this.expiresTime, this.refreshToken, this.userId,
      this.type);
  factory LoginModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginModelFromJson(srcJson);

  String? accessToken;

  int? expiresTime;

  String? refreshToken;

  int? userId;

  ///  register  login
  String? type;

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
