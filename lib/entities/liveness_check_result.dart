import 'package:json_annotation/json_annotation.dart';

part 'liveness_check_result.g.dart';

@JsonSerializable()
class LivenessCheckResult extends Object {
  LivenessCheckResult(
    this.result,
    this.score,
  );
  factory LivenessCheckResult.fromJson(Map<String, dynamic> srcJson) =>
      _$LivenessCheckResultFromJson(srcJson);

  @JsonKey(name: 'result')
  bool? result;

  @JsonKey(name: 'score')
  int? score;

  Map<String, dynamic> toJson() => _$LivenessCheckResultToJson(this);
}
