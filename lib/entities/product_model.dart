//
//  Product.dart
//
//
//  Created by JSONConverter on 2023/03/28.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product extends Object {
  Product(
    this.banners,
    this.product,
  );
  factory Product.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductFromJson(srcJson);

  @JsonKey(name: 'banners')
  List<String>? banners;

  @JsonKey(name: 'product')
  ProductProduct? product;

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductProduct extends Object {
  ProductProduct(
    this.list,
    this.total,
  );
  factory ProductProduct.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductProductFromJson(srcJson);

  @JsonKey(name: 'list')
  List<ProductListItem>? list;

  @JsonKey(name: 'total')
  num? total;

  Map<String, dynamic> toJson() => _$ProductProductToJson(this);
}

@JsonSerializable()
class ProductListItem extends Object {
  ProductListItem(
      this.autoLending,
      this.createTime,
      this.creator,
      this.defaultLoanAmount,
      this.deferDays,
      this.deleted,
      this.id,
      this.imSwitches,
      this.incrementAmount,
      this.loanTerm,
      this.maxLoanAmount,
      this.orderIndex,
      this.overdueRate,
      this.payLoanChannel,
      this.payRepayChannel,
      this.productLogo,
      this.productName,
      this.remark,
      this.repaymentRate,
      this.serviceAmountRate,
      this.status,
      this.stopLending,
      this.tenantId,
      this.updater,
      this.updateTime,
      this.disbursementTime);
  factory ProductListItem.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductListItemFromJson(srcJson);

  @JsonKey(name: 'autoLending')
  num? autoLending;

  @JsonKey(name: 'createTime')
  num? createTime;

  @JsonKey(name: 'creator')
  String? creator;

  @JsonKey(name: 'defaultLoanAmount')
  num? defaultLoanAmount;

  @JsonKey(name: 'deferDays')
  num? deferDays;

  @JsonKey(name: 'deleted')
  bool? deleted;

  @JsonKey(name: 'id')
  num? id;

  @JsonKey(name: 'imSwitches')
  num? imSwitches;

  @JsonKey(name: 'incrementAmount')
  num? incrementAmount;

  @JsonKey(name: 'loanTerm')
  num? loanTerm;

  @JsonKey(name: 'maxLoanAmount')
  num? maxLoanAmount;

  @JsonKey(name: 'orderIndex')
  num? orderIndex;

  @JsonKey(name: 'overdueRate')
  num? overdueRate;

  @JsonKey(name: 'payLoanChannel')
  String? payLoanChannel;

  @JsonKey(name: 'payRepayChannel')
  String? payRepayChannel;

  @JsonKey(name: 'productLogo')
  String? productLogo;

  @JsonKey(name: 'productName')
  String? productName;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'repaymentRate')
  num? repaymentRate;

  @JsonKey(name: 'serviceAmountRate')
  num? serviceAmountRate;

  @JsonKey(name: 'status')
  num? status;

  @JsonKey(name: 'stopLending')
  num? stopLending;

  @JsonKey(name: 'tenantId')
  num? tenantId;

  @JsonKey(name: 'updater')
  String? updater;

  @JsonKey(name: 'updateTime')
  num? updateTime;

  @JsonKey(name: 'disbursementTime', defaultValue: '')
  String disbursementTime;

  Map<String, dynamic> toJson() => _$ProductListItemToJson(this);
}
