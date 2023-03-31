//
//  Loan.dart
//
//
//  Created by JSONConverter on 2023/03/07.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loan_product_model.g.dart';

@JsonSerializable()
class LoanProductModel extends Object {
  LoanProductModel(
    this.amountDetails,
    this.failMessage,
    this.loanStatus,
    this.product,
    this.tenure,
  );
  factory LoanProductModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoanProductModelFromJson(srcJson);

  @JsonKey(name: 'amountDetails', defaultValue: [])
  List<LoanAmountDetails> amountDetails;

  String? failMessage;

  @JsonKey(name: 'loanStatus', defaultValue: false)
  bool loanStatus;

  @JsonKey(name: 'product', defaultValue: [])
  List<LoanProduct> product;

  @JsonKey(name: 'tenure', defaultValue: [])
  List<num> tenure;

  Map<String, dynamic> toJson() => _$LoanProductModelToJson(this);
}

@JsonSerializable()
class LoanAmountDetails extends Object with EquatableMixin {
  LoanAmountDetails(
    this.amount,
    this.check,
    this.productIds,
  );
  factory LoanAmountDetails.fromJson(Map<String, dynamic> srcJson) =>
      _$LoanAmountDetailsFromJson(srcJson);

  double? amount;

  @JsonKey(name: 'check', defaultValue: false)
  bool check;

  @JsonKey(name: 'productIds', defaultValue: [])
  List<int> productIds;

  Map<String, dynamic> toJson() => _$LoanAmountDetailsToJson(this);

  @override
  List<Object?> get props => [amount, productIds];
}

@JsonSerializable()
class LoanProduct extends Object {
  LoanProduct(
    this.check,
    this.defaultLoanAmount,
    this.id,
    this.productLogo,
    this.productName,
  );
  factory LoanProduct.fromJson(Map<String, dynamic> srcJson) =>
      _$LoanProductFromJson(srcJson);

  bool? check;

  double? defaultLoanAmount;

  int? id;

  String? productLogo;

  String? productName;

  Map<String, dynamic> toJson() => _$LoanProductToJson(this);
}
