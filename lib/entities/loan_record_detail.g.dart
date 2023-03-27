// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_record_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanRecordDetail _$LoanRecordDetailFromJson(Map<String, dynamic> json) =>
    LoanRecordDetail(
      json['loanAmount'] as num?,
      json['productLogo'] as String?,
      json['productName'] as String?,
      json['repayAmount'] as num?,
      json['repaidDate'] as String?,
      json['overdueAmount'] as num?,
      json['status'] as num?,
    );

Map<String, dynamic> _$LoanRecordDetailToJson(LoanRecordDetail instance) =>
    <String, dynamic>{
      'overdueAmount': instance.overdueAmount,
      'repaidDate': instance.repaidDate,
      'loanAmount': instance.loanAmount,
      'repayAmount': instance.repayAmount,
      'productLogo': instance.productLogo,
      'productName': instance.productName,
      'status': instance.status,
    };
