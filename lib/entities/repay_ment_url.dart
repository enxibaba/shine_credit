import 'package:json_annotation/json_annotation.dart';

part 'repay_ment_url.g.dart';

@JsonSerializable()
class RepayMentUrl extends Object {
  RepayMentUrl(
    this.fileUrl,
  );
  factory RepayMentUrl.fromJson(Map<String, dynamic> srcJson) =>
      _$RepayMentUrlFromJson(srcJson);

  @JsonKey(name: 'fileUrl')
  String? fileUrl;

  Map<String, dynamic> toJson() => _$RepayMentUrlToJson(this);
}
