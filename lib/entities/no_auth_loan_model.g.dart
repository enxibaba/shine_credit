// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_auth_loan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoAuthLoanModel _$NoAuthLoanModelFromJson(Map<String, dynamic> json) =>
    NoAuthLoanModel(
      json['loanAmount'] as String?,
      json['rate'] as String?,
      json['receivedAmount'] as String?,
      json['serviceRate'] as String?,
      json['tenure'] as String?,
      json['totalInterest'] as String?,
    );

Map<String, dynamic> _$NoAuthLoanModelToJson(NoAuthLoanModel instance) =>
    <String, dynamic>{
      'loanAmount': instance.loanAmount,
      'rate': instance.rate,
      'receivedAmount': instance.receivedAmount,
      'serviceRate': instance.serviceRate,
      'tenure': instance.tenure,
      'totalInterest': instance.totalInterest,
    };
