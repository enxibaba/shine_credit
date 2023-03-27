//
//  LoanRecordModel.dart
//
//
//  Created by JSONConverter on 2023/03/26.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shine_credit/res/colors.dart';

part 'loan_record_detail.g.dart';

@JsonSerializable()
class LoanRecordDetail extends Object {
  LoanRecordDetail(
    this.loanAmount,
    this.productLogo,
    this.productName,
    this.repayAmount,
    this.repaidDate,
    this.overdueAmount,
    this.status,
  );
  factory LoanRecordDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$LoanRecordDetailFromJson(srcJson);

  @JsonKey(name: 'overdueAmount')
  num? overdueAmount;

  @JsonKey(name: 'repaidDate')
  String? repaidDate;

  @JsonKey(name: 'loanAmount')
  num? loanAmount;

  @JsonKey(name: 'repayAmount')
  num? repayAmount;

  @JsonKey(name: 'productLogo')
  String? productLogo;

  @JsonKey(name: 'productName')
  String? productName;

  @JsonKey(name: 'status')
  num? status;

  Map<String, dynamic> toJson() => _$LoanRecordDetailToJson(this);

  //0:"In Review"//申请成功待审核
  //1:"AUTO AUDIT SUCCESS"//自动审核通过
  //2:"Audit reject"//"AUTO_AUDIT_FAIL"自动审核不通过
  //3:"MANUAL REVIEW"//自动审核未决待人工复审
  //4:"MANUAL REVIEW SUCCESS"//人工复审通过
  //5:"Audit reject"//"MANUAL_REVIEW_FAIL"//人工复审不通过
  //6:"WAIT LOAN AUDIT"//待放款审核
  //7:"LOAN AUDIT SUCCESS"//放款审核通过
  //8:"Audit reject"//"LOAN_AUDIT_FAIL"//放款审核拒绝
  //9:"LOANING"//放款中
  //10:"LOAN SUCCESS"//放款成功
  //11:"LOAN FAIL"//放款失败
  //12:"PENDING REPAYMENT"//待还款
  //13:"REPAY REDUCE"//减免还款
  //14:"OVERDUE"//已逾期
  //15:"REPAID"//已还款
  //16:"BAD DEBTS"//坏账
  //17:"EXTENSION"//展期中
  //else:"UNKNOWN_STATUS"//未知
  String get statusText {
    switch (status) {
      case 0:
        return 'In Review';
      case 1:
        return 'AUTO AUDIT SUCCESS';
      case 2:
        return 'Audit reject';
      case 3:
        return 'MANUAL REVIEW';
      case 4:
        return 'MANUAL REVIEW SUCCESS';
      case 5:
        return 'Audit reject';
      case 6:
        return 'WAIT LOAN AUDIT';
      case 7:
        return 'LOAN AUDIT SUCCESS';
      case 8:
        return 'Audit reject';
      case 9:
        return 'LOANING';
      case 10:
        return 'LOAN SUCCESS';
      case 11:
        return 'LOAN FAIL';
      case 12:
        return 'PENDING REPAYMENT';
      case 13:
        return 'REPAY REDUCE';
      case 14:
        return 'OVERDUE';
      case 15:
        return 'REPAID';
      case 16:
        return 'BAD DEBTS';
      case 17:
        return 'EXTENSION';
      default:
        return 'UNKNOWN_STATUS';
    }
  }

  //展示还款按钮
  bool get repayHide {
    // 0,1,2,3,4,5,6,7,8,9,11
    return status == 0 ||
        status == 1 ||
        status == 2 ||
        status == 3 ||
        status == 4 ||
        status == 5 ||
        status == 6 ||
        status == 7 ||
        status == 8 ||
        status == 9 ||
        status == 11;
  }

  //展示展期按钮
  bool get extensionShow {
    // 12,14,16,17
    return status == 12 || status == 14 || status == 16 || status == 17;
  }

  Color get statusColor {
    switch (status) {
      case 1:
        return Colours.app_main;
      case 2:
        return Colours.red;
      case 6:
        return Colours.app_main;
      case 7:
        return Colours.app_main;
      case 8:
        return Colours.red;
      default:
        return Colours.text_gray;
    }
  }
}
