// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      (json['banners'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['product'] == null
          ? null
          : ProductProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'banners': instance.banners,
      'product': instance.product,
    };

ProductProduct _$ProductProductFromJson(Map<String, dynamic> json) =>
    ProductProduct(
      (json['list'] as List<dynamic>?)
          ?.map((e) => ProductListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as num?,
    );

Map<String, dynamic> _$ProductProductToJson(ProductProduct instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
    };

ProductListItem _$ProductListItemFromJson(Map<String, dynamic> json) =>
    ProductListItem(
      json['autoLending'] as num?,
      json['createTime'] as num?,
      json['creator'] as String?,
      json['defaultLoanAmount'] as num?,
      json['deferDays'] as num?,
      json['deleted'] as bool?,
      json['id'] as num?,
      json['imSwitches'] as num?,
      json['incrementAmount'] as num?,
      json['loanTerm'] as num?,
      json['maxLoanAmount'] as num?,
      json['orderIndex'] as num?,
      json['overdueRate'] as num?,
      json['payLoanChannel'] as String?,
      json['payRepayChannel'] as String?,
      json['productLogo'] as String?,
      json['productName'] as String?,
      json['remark'] as String?,
      json['repaymentRate'] as num?,
      json['serviceAmountRate'] as num?,
      json['status'] as num?,
      json['stopLending'] as num?,
      json['tenantId'] as num?,
      json['updater'] as String?,
      json['updateTime'] as num?,
      json['disbursementTime'] as String? ?? '',
    );

Map<String, dynamic> _$ProductListItemToJson(ProductListItem instance) =>
    <String, dynamic>{
      'autoLending': instance.autoLending,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'defaultLoanAmount': instance.defaultLoanAmount,
      'deferDays': instance.deferDays,
      'deleted': instance.deleted,
      'id': instance.id,
      'imSwitches': instance.imSwitches,
      'incrementAmount': instance.incrementAmount,
      'loanTerm': instance.loanTerm,
      'maxLoanAmount': instance.maxLoanAmount,
      'orderIndex': instance.orderIndex,
      'overdueRate': instance.overdueRate,
      'payLoanChannel': instance.payLoanChannel,
      'payRepayChannel': instance.payRepayChannel,
      'productLogo': instance.productLogo,
      'productName': instance.productName,
      'remark': instance.remark,
      'repaymentRate': instance.repaymentRate,
      'serviceAmountRate': instance.serviceAmountRate,
      'status': instance.status,
      'stopLending': instance.stopLending,
      'tenantId': instance.tenantId,
      'updater': instance.updater,
      'updateTime': instance.updateTime,
      'disbursementTime': instance.disbursementTime,
    };
