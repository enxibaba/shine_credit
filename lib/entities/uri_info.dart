import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'uri_info.g.dart';

@JsonSerializable()
class UriInfo {
  UriInfo(
    this.title,
    this.url,
  );

  factory UriInfo.fromJsonString(String jsonString) {
    Map<String, dynamic>? srcJson =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return _$UriInfoFromJson(srcJson);
  }

  factory UriInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UriInfoFromJson(srcJson);

  String title;

  String url;

  Map<String, dynamic> toJson() => _$UriInfoToJson(this);

  String encodingJsonString() => jsonEncode(this);
}
