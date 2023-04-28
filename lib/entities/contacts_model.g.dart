// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) =>
    ContactsModel(
      json['contactsId'] as String?,
      json['contactTimes'] as String?,
      json['email'] as String?,
      json['name'] as String?,
      json['phone'] as String?,
      json['times'] as String?,
    );

Map<String, dynamic> _$ContactsModelToJson(ContactsModel instance) =>
    <String, dynamic>{
      'contactsId': instance.contactsId,
      'contactTimes': instance.contactTimes,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'times': instance.times,
    };
