// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repayment_index_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepaymentIndexModel _$RepaymentIndexModelFromJson(Map<String, dynamic> json) =>
    RepaymentIndexModel(
      json['calculationFormulaDesc'] as String? ?? '',
      json['loanRate'] as String? ?? '',
      json['receivedAmount'] as String? ?? '',
      json['repaymentDate'] as String? ?? '',
    );

Map<String, dynamic> _$RepaymentIndexModelToJson(
        RepaymentIndexModel instance) =>
    <String, dynamic>{
      'calculationFormulaDesc': instance.calculationFormulaDesc,
      'loanRate': instance.loanRate,
      'receivedAmount': instance.receivedAmount,
      'repaymentDate': instance.repaymentDate,
    };
