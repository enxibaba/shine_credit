// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rollover_pay_ment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RolloverPayMentModel _$RolloverPayMentModelFromJson(
        Map<String, dynamic> json) =>
    RolloverPayMentModel(
      json['dueTimeAfterExtension'] as String? ?? '',
      json['expirationTime'] as String? ?? '',
      json['extendPaymentPeriod'] as num? ?? 0,
      json['extendRepaymentFee'] as num? ?? 0,
      json['loanAmount'] as num? ?? 0,
      json['overdueAmount'] as String? ?? '',
      json['repaymentAmount'] as num? ?? 0,
    );

Map<String, dynamic> _$RolloverPayMentModelToJson(
        RolloverPayMentModel instance) =>
    <String, dynamic>{
      'dueTimeAfterExtension': instance.dueTimeAfterExtension,
      'expirationTime': instance.expirationTime,
      'extendPaymentPeriod': instance.extendPaymentPeriod,
      'extendRepaymentFee': instance.extendRepaymentFee,
      'loanAmount': instance.loanAmount,
      'overdueAmount': instance.overdueAmount,
      'repaymentAmount': instance.repaymentAmount,
    };
