//
//  RolloverPayMentModel.dart
//
//
//  Created by JSONConverter on 2023/03/31.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'rollover_pay_ment_model.g.dart';

@JsonSerializable()
class RolloverPayMentModel extends Object {
  RolloverPayMentModel(
    this.dueTimeAfterExtension,
    this.expirationTime,
    this.extendPaymentPeriod,
    this.extendRepaymentFee,
    this.loanAmount,
    this.overdueAmount,
    this.repaymentAmount,
  );
  factory RolloverPayMentModel.fromJson(Map<String, dynamic> srcJson) =>
      _$RolloverPayMentModelFromJson(srcJson);

  @JsonKey(name: 'dueTimeAfterExtension', defaultValue: '')
  String dueTimeAfterExtension;

  /// 还款时间
  @JsonKey(name: 'expirationTime', defaultValue: '')
  String expirationTime;

  ///延期天数
  @JsonKey(name: 'extendPaymentPeriod', defaultValue: 0)
  num extendPaymentPeriod;

  /// 延期费用
  @JsonKey(name: 'extendRepaymentFee', defaultValue: 0)
  num extendRepaymentFee;

  /// 借款金额
  @JsonKey(name: 'loanAmount', defaultValue: 0)
  num loanAmount;

  /// 逾期金额
  @JsonKey(name: 'overdueAmount', defaultValue: '')
  String overdueAmount;

  /// 应还款金额总金额
  @JsonKey(name: 'repaymentAmount', defaultValue: 0)
  num repaymentAmount;

  Map<String, dynamic> toJson() => _$RolloverPayMentModelToJson(this);
}
