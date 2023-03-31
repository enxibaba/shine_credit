//
//  Auth.dart
//
//
//  Created by JSONConverter on 2023/03/08.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'loan_auth_model.g.dart';

@JsonSerializable()
class LoanAuthModel extends Object {
  LoanAuthModel(
    this.apr,
    this.loanAmount,
    this.tenure,
    this.userCertification,
  );
  factory LoanAuthModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoanAuthModelFromJson(srcJson);

  @JsonKey(name: 'apr')
  String? apr;

  @JsonKey(name: 'loanAmount')
  String? loanAmount;

  @JsonKey(name: 'tenure')
  String? tenure;

  @JsonKey(name: 'userCertification')
  AuthUserCertification? userCertification;

  Map<String, dynamic> toJson() => _$LoanAuthModelToJson(this);
}

@JsonSerializable()
class AuthUserCertification extends Object {
  AuthUserCertification(
    this.authentication,
    this.bandCard,
    this.emergencyContact,
    this.faceAuthentication,
  );
  factory AuthUserCertification.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthUserCertificationFromJson(srcJson);

  @JsonKey(name: 'authentication', defaultValue: false)
  bool authentication;

  @JsonKey(name: 'bandCard', defaultValue: false)
  bool bandCard;

  @JsonKey(name: 'emergencyContact', defaultValue: false)
  bool emergencyContact;

  @JsonKey(name: 'faceAuthentication', defaultValue: false)
  bool faceAuthentication;

  Map<String, dynamic> toJson() => _$AuthUserCertificationToJson(this);

  bool get allCertification => authentication && bandCard && emergencyContact && faceAuthentication;
}
