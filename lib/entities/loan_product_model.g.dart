// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanProductModel _$LoanProductModelFromJson(Map<String, dynamic> json) =>
    LoanProductModel(
      (json['amountDetails'] as List<dynamic>?)
              ?.map(
                  (e) => LoanAmountDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['failMessage'] as String?,
      json['loanStatus'] as bool? ?? false,
      (json['product'] as List<dynamic>?)
              ?.map((e) => LoanProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['tenure'] as List<dynamic>?)?.map((e) => e as num).toList() ?? [],
    );

Map<String, dynamic> _$LoanProductModelToJson(LoanProductModel instance) =>
    <String, dynamic>{
      'amountDetails': instance.amountDetails,
      'failMessage': instance.failMessage,
      'loanStatus': instance.loanStatus,
      'product': instance.product,
      'tenure': instance.tenure,
    };

LoanAmountDetails _$LoanAmountDetailsFromJson(Map<String, dynamic> json) =>
    LoanAmountDetails(
      (json['amount'] as num?)?.toDouble(),
      json['check'] as bool? ?? false,
      (json['productIds'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          [],
    );

Map<String, dynamic> _$LoanAmountDetailsToJson(LoanAmountDetails instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'check': instance.check,
      'productIds': instance.productIds,
    };

LoanProduct _$LoanProductFromJson(Map<String, dynamic> json) => LoanProduct(
      json['check'] as bool?,
      (json['defaultLoanAmount'] as num?)?.toDouble(),
      json['id'] as int?,
      json['productLogo'] as String?,
      json['productName'] as String?,
    );

Map<String, dynamic> _$LoanProductToJson(LoanProduct instance) =>
    <String, dynamic>{
      'check': instance.check,
      'defaultLoanAmount': instance.defaultLoanAmount,
      'id': instance.id,
      'productLogo': instance.productLogo,
      'productName': instance.productName,
    };
