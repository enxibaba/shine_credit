import 'package:json_annotation/json_annotation.dart';

part 'base_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResult<T> {
  BaseResult({this.code, this.message, this.data});
  factory BaseResult.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResultFromJson(json, fromJsonT);
  String? code;
  String? message;
  T? data;

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResultToJson(this, toJsonT);
}
