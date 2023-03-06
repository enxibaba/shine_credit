//
//  NoAuthLoanModel.dart
//
//
//  Created by JSONConverter on 2023/03/06.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'no_auth_loan_model.g.dart';

@JsonSerializable()
class NoAuthLoanModel extends Object {
  NoAuthLoanModel(
    this.loanAmount,
    this.rate,
    this.receivedAmount,
    this.serviceRate,
    this.tenure,
    this.totalInterest,
  );
  factory NoAuthLoanModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NoAuthLoanModelFromJson(srcJson);

  String? loanAmount;

  String? rate;

  String? receivedAmount;

  String? serviceRate;

  String? tenure;

  String? totalInterest;

  Map<String, dynamic> toJson() => _$NoAuthLoanModelToJson(this);
}
