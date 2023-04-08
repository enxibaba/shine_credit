//
//  UpdateModel.dart
//
//
//  Created by JSONConverter on 2023/04/04.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'update_model.g.dart';

@JsonSerializable()
class UpdateModel extends Object {
  UpdateModel(
    this.forceUpdate,
    this.innerVersion,
    this.update,
    this.updateMsg,
    this.updateUrl,
    this.version,
  );
  factory UpdateModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UpdateModelFromJson(srcJson);

  @JsonKey(name: 'forceUpdate', defaultValue: false)
  bool forceUpdate;

  @JsonKey(name: 'innerVersion')
  num? innerVersion;

  @JsonKey(name: 'update', defaultValue: false)
  bool update;

  @JsonKey(name: 'updateMsg')
  String? updateMsg;

  @JsonKey(name: 'updateUrl')
  String? updateUrl;

  @JsonKey(name: 'version')
  String? version;

  Map<String, dynamic> toJson() => _$UpdateModelToJson(this);
}
