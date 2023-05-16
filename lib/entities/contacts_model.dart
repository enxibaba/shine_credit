//
//  ContactsModel.dart
//
//
//  Created by JSONConverter on 2023/04/28.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'contacts_model.g.dart';

@JsonSerializable()
class ContactsModel extends Object {
  ContactsModel(
    this.contactsId,
    this.contactTimes,
    this.email,
    this.name,
    this.phone,
    this.times,
  );
  factory ContactsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ContactsModelFromJson(srcJson);

  @JsonKey(name: 'contactsId')
  String? contactsId;

  @JsonKey(name: 'contactTimes')
  int? contactTimes;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'times')
  DateTime? times;

  Map<String, dynamic> toJson() => _$ContactsModelToJson(this);
}
