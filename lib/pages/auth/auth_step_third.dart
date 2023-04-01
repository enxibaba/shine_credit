// ignore_for_file: unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shine_credit/entities/diction_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/auth/widgets/auth_detial_header.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/theme_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/my_scroll_view.dart';
import 'package:shine_credit/widgets/selected_item.dart';

class AuthStepThird extends StatefulWidget {
  const AuthStepThird({super.key});

  @override
  State<AuthStepThird> createState() => _AuthStepThirdState();
}

class _AuthStepThirdState extends State<AuthStepThird> {
  List<DictionModel> _backList = [];

  DictionModel? _bankModel;

  final TextEditingController _beneficiaryController = TextEditingController();
  final TextEditingController _iFSCController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();

  @override
  void initState() {
    super.initState();
    requestDic();
  }

  Future<void> requestDic() async {
    final tmp = await DioUtils.instance.client
        .requestDictData(tenantId: '1', body: {'dictType': 'supported_banks'});
    _backList = tmp.data;
  }

  void _showPopup(DictionModel? select) {
    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  color: context.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26))),
              child: ListView(
                  children: ListTile.divideTiles(
                      context: context,
                      tiles: _backList.map((e) {
                        return ListTile(
                          splashColor: Colours.app_main_bg,
                          title: Text(e.label!),
                          selected: select?.value == e.value,
                          onTap: () {
                            setState(() {
                              _bankModel = e;
                            });
                            Navigator.pop(context);
                          },
                        );
                      })).toList()),
            ),
          );
        });
  }

  Future<void> _verify() async {
    final beneficiaryName = _beneficiaryController.text;
    final ifscCode = _iFSCController.text;
    final accountNumber = _accountController.text;

    if (_bankModel == null) {
      ToastUtils.show('Bank Name can not be empty');
      return;
    }

    if (beneficiaryName.isEmpty) {
      ToastUtils.show('Beneficiary Name can not be empty');
      return;
    }

    if (ifscCode.isEmpty) {
      ToastUtils.show('IFSC Code can not be empty');
      return;
    }

    if (accountNumber.isEmpty) {
      ToastUtils.show('Account Number can not be empty');
      return;
    }

    final params = {
      'bankName': _bankModel!.label,
      'beneficiaryName': beneficiaryName,
      'ifscCode': ifscCode,
      'accountNumber': accountNumber,
    };

    ToastUtils.showLoading();

    try {
      final result = await DioUtils.instance.client
          .uploadBankCard(tenantId: '1', body: params);

      if (result.code == 0) {
        ToastUtils.cancelToast();
        if (context.mounted) {
          final isBack = await Navigator.maybePop(context);
          if (!isBack) {
            await SystemNavigator.pop();
          }
        }
      }
    } catch (e) {
      AppUtils.log.d(e);
      ToastUtils.show('something error, please try later');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          centerTitle: 'Emergency Contacts(3/4)',
          backgroundColor: Colours.app_main,
        ),
        resizeToAvoidBottomInset: defaultTargetPlatform != TargetPlatform.iOS,
        body: MyScrollView(
            keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[
              _nodeText1,
              _nodeText2,
              _nodeText3,
            ]),
            padding: const EdgeInsets.all(15),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            bottomButton:
                MyDecoratedButton(onPressed: _verify, text: 'Next', radius: 24),
            children: [
              const AuthDetailHeader(),
              Gaps.vGap15,
              MyCard(
                  child: Column(
                children: [
                  SelectedItem(
                    title: 'Bank Name',
                    textAlign: TextAlign.right,
                    content: _bankModel == null
                        ? 'Bank of India'
                        : _bankModel!.label.nullSafe,
                    style: TextStyle(
                        color: _bankModel == null
                            ? Colours.text_gray
                            : Colours.text,
                        fontSize: Dimens.font_sp12),
                    onTap: () => _showPopup(_bankModel),
                    showLine: true,
                  ),
                  FormTextFieldItem(
                    key: const Key('beneficiary'),
                    controller: _beneficiaryController,
                    focusNode: _nodeText1,
                    title: 'Beneficiary Name',
                    hintText: 'Match with Aadhaar',
                  ),
                  FormTextFieldItem(
                    key: const Key('IFSC'),
                    controller: _iFSCController,
                    focusNode: _nodeText2,
                    title: 'IFSC Code',
                    hintText: 'Enter IFSC code',
                  ),
                  Container(
                    height: 1,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Gaps.line,
                  ),
                  FormTextFieldItem(
                    key: const Key('account'),
                    controller: _accountController,
                    focusNode: _nodeText3,
                    title: 'Account Number',
                    hintText: 'Enter account number',
                  ),
                ],
              )),
              Gaps.vGap24,
              const Text(Constant.bankTips,
                  style: TextStyle(
                      fontSize: Dimens.font_sp14, color: Colours.text_regular)),
              Gaps.vGap32,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LoadAssetImage('important', width: 15, height: 15),
                  Gaps.hGap10,
                  Text('Please confirm all information is true ',
                      style: TextStyle(
                          fontSize: Dimens.font_sp15, color: Colours.red)),
                ],
              ),
            ]));
  }
}

class FormTextFieldItem extends StatelessWidget {
  const FormTextFieldItem({
    super.key,
    required this.focusNode,
    required this.hintText,
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 15, color: Colours.text)),
          Gaps.hGap10,
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 12, color: Colours.text),
              textAlign: TextAlign.right,
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                  hintText: hintText,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle:
                      const TextStyle(fontSize: 12, color: Colours.text_gray)),
            ),
          )
        ],
      ),
    );
  }
}
