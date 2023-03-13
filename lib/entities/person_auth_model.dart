//
//  PersonAuthModel.dart
//
//
//  Created by JSONConverter on 2023/03/11.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'person_auth_model.g.dart';

@JsonSerializable()
class PersonAuthModel extends Object {
  PersonAuthModel(
    this.adCardNo,
    this.adCardOcrName,
    this.birthday,
    this.memberAddress,
    this.memberPin,
    this.panNo,
    this.panOcrName,
    this.sex,
  );
  factory PersonAuthModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonAuthModelFromJson(srcJson);

  static final PersonAuthModel empty =
      PersonAuthModel('', '', '', '', '', '', '', '');

  @JsonKey(name: 'adCardNo')
  String? adCardNo;

  @JsonKey(name: 'adCardOcrName')
  String? adCardOcrName;

  @JsonKey(name: 'birthday')
  String? birthday;

  @JsonKey(name: 'memberAddress')
  String? memberAddress;

  @JsonKey(name: 'memberPin')
  String? memberPin;

  @JsonKey(name: 'panNo')
  String? panNo;

  @JsonKey(name: 'panOcrName')
  String? panOcrName;

  @JsonKey(name: 'sex')
  String? sex;

  Map<String, dynamic> toJson() => _$PersonAuthModelToJson(this);
}
