//
//  RepaymentIndexModel.dart
//
//
//  Created by JSONConverter on 2023/03/30.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'repayment_index_model.g.dart';

@JsonSerializable()
class RepaymentIndexModel extends Object {
  RepaymentIndexModel(
    this.calculationFormulaDesc,
    this.loanRate,
    this.receivedAmount,
    this.repaymentDate,
  );
  factory RepaymentIndexModel.fromJson(Map<String, dynamic> srcJson) =>
      _$RepaymentIndexModelFromJson(srcJson);

  @JsonKey(name: 'calculationFormulaDesc', defaultValue: '')
  String calculationFormulaDesc;

  @JsonKey(name: 'loanRate', defaultValue: '')
  String loanRate;

  @JsonKey(name: 'receivedAmount', defaultValue: '')
  String receivedAmount;

  @JsonKey(name: 'repaymentDate', defaultValue: '')
  String repaymentDate;

  Map<String, dynamic> toJson() => _$RepaymentIndexModelToJson(this);
}
