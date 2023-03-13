import 'package:json_annotation/json_annotation.dart';

part 'upload_file_model.g.dart';

@JsonSerializable()
class UploadFileModel extends Object {
  UploadFileModel(
    this.fileUrl,
  );
  factory UploadFileModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UploadFileModelFromJson(srcJson);

  @JsonKey(name: 'fileUrl')
  String? fileUrl;

  Map<String, dynamic> toJson() => _$UploadFileModelToJson(this);
}
