// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanRecordModel _$LoanRecordModelFromJson(Map<String, dynamic> json) =>
    LoanRecordModel(
      json['applyTime'] as String?,
      json['auditStatus'] as num?,
      json['expirationTime'] as String?,
      json['loanAmount'] as num?,
      json['orderNumber'] as String?,
      json['productLogo'] as String?,
      json['productName'] as String?,
      json['loanTime'] as String?,
      json['status'] as num?,
    );

Map<String, dynamic> _$LoanRecordModelToJson(LoanRecordModel instance) =>
    <String, dynamic>{
      'applyTime': instance.applyTime,
      'loanTime': instance.loanTime,
      'auditStatus': instance.auditStatus,
      'expirationTime': instance.expirationTime,
      'loanAmount': instance.loanAmount,
      'orderNumber': instance.orderNumber,
      'productLogo': instance.productLogo,
      'productName': instance.productName,
      'status': instance.status,
    };
