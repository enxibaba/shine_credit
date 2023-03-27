//
//  DictionModel.dart
//
//
//  Created by JSONConverter on 2023/03/26.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'diction_model.g.dart';

@JsonSerializable()
class DictionModel extends Object {
  DictionModel(
    this.colorType,
    this.remark,
    this.dictType,
    this.label,
    this.value,
  );
  factory DictionModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DictionModelFromJson(srcJson);

  @JsonKey(name: 'colorType')
  String? colorType;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'dictType')
  String? dictType;

  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'value')
  String? value;

  Map<String, dynamic> toJson() => _$DictionModelToJson(this);
}
