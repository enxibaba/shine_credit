import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:shine_credit/entities/person_auth_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/auth/widgets/auth_detial_header.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/my_scroll_view.dart';
import 'package:shine_credit/widgets/selected_item.dart';

class AuthStepFirstDetail extends StatefulWidget {
  const AuthStepFirstDetail({super.key, this.authModel});

  final PersonAuthModel? authModel;

  @override
  State<AuthStepFirstDetail> createState() => _AuthStepFirstDetailState();
}

class _AuthStepFirstDetailState extends State<AuthStepFirstDetail> {
  late PersonAuthModel _authModel;

  var _marriedValue = 'Married';

  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final FocusNode _nodeText4 = FocusNode();

  @override
  void initState() {
    super.initState();
    _authModel = widget.authModel ?? PersonAuthModel.empty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          centerTitle: 'Identification(1/4)',
          backgroundColor: Colours.app_main,
        ), // ,
        body: MyScrollView(
            keyboardConfig: Utils.getKeyboardActionsConfig(context,
                <FocusNode>[_nodeText1, _nodeText2, _nodeText3, _nodeText4]),
            padding: const EdgeInsets.all(16),
            children: [
              const AuthDetailHeader(),
              Gaps.vGap15,
              MyCard(
                  child: Column(children: [
                SelectedItem(
                    title: 'Name（Aadhaar）',
                    content: _authModel.adCardOcrName.nullSafe,
                    showLine: true,
                    trailing: Gaps.empty,
                    textAlign: TextAlign.end),
                SelectedItem(
                    title: 'Name（PAN）',
                    content: _authModel.panOcrName.nullSafe,
                    showLine: true,
                    trailing: Gaps.empty,
                    textAlign: TextAlign.end),
                SelectedItem(
                    title: 'Pan No.',
                    content: _authModel.panNo.nullSafe,
                    showLine: true,
                    trailing: Gaps.empty,
                    textAlign: TextAlign.end),
                SelectedItem(
                    title: 'Aadhaar No.',
                    content: _authModel.adCardNo.nullSafe,
                    showLine: true,
                    trailing: Gaps.empty,
                    textAlign: TextAlign.end),
                SelectedItem(
                    title: 'Date Of Birth',
                    content: _authModel.birthday.nullSafe,
                    showLine: true,
                    trailing: Gaps.empty,
                    textAlign: TextAlign.end),
                SelectedItem(
                    title: 'Occupation',
                    showLine: true,
                    trailing: SizedBox(
                        width: 220,
                        child: TextField(
                            style: const TextStyle(
                                color: Colours.text_regular,
                                fontSize: Dimens.font_sp14),
                            textAlign: TextAlign.end,
                            controller: _jobController,
                            focusNode: _nodeText1,
                            decoration: const InputDecoration(
                                hintText: 'Please enter Occupation',
                                border: InputBorder.none)))),
                SelectedItem(
                  title: 'Married',
                  showLine: true,
                  trailing: SizedBox(
                    width: 240,
                    child: RadioGroup<String>.builder(
                        horizontalAlignment: MainAxisAlignment.end,
                        direction: Axis.horizontal,
                        groupValue: _marriedValue,
                        onChanged: (value) => setState(() {
                              _marriedValue = value!;
                            }),
                        items: const ['Married', 'unmarried'],
                        activeColor: Colours.app_main,
                        itemBuilder: (item) => RadioButtonBuilder(
                              item,
                              textPosition: RadioButtonTextPosition.right,
                            )),
                  ),
                ),
                SelectedItem(
                  title: 'Religion',
                  showLine: true,
                  trailing: SizedBox(
                    width: 220,
                    child: TextField(
                        style: const TextStyle(
                            color: Colours.text_regular,
                            fontSize: Dimens.font_sp14),
                        textAlign: TextAlign.end,
                        controller: _religionController,
                        focusNode: _nodeText2,
                        decoration: const InputDecoration(
                            hintText: 'Please enter religion',
                            border: InputBorder.none)),
                  ),
                ),
                SelectedItem(
                  title: 'Revenue',
                  showLine: true,
                  trailing: SizedBox(
                    width: 220,
                    child: TextField(
                        style: const TextStyle(
                            color: Colours.text_regular,
                            fontSize: Dimens.font_sp14),
                        textAlign: TextAlign.end,
                        controller: _revenueController,
                        focusNode: _nodeText3,
                        decoration: const InputDecoration(
                            hintText: 'Please enter revenue',
                            border: InputBorder.none)),
                  ),
                ),
                SelectedItem(
                    title: 'Gender',
                    content: _authModel.sex.nullSafe,
                    showLine: true,
                    trailing: Gaps.empty,
                    textAlign: TextAlign.end),
                SelectedItem(
                    title: 'Pincode',
                    content: _authModel.memberPin.nullSafe,
                    showLine: true,
                    trailing: Gaps.empty,
                    textAlign: TextAlign.end),
                SelectedItem(
                  title: 'Email',
                  showLine: true,
                  trailing: SizedBox(
                    width: 220,
                    child: TextField(
                        style: const TextStyle(
                            color: Colours.text_regular,
                            fontSize: Dimens.font_sp14),
                        textAlign: TextAlign.end,
                        controller: _emailController,
                        focusNode: _nodeText4,
                        decoration: const InputDecoration(
                            hintText: 'Please enter Personal Email',
                            border: InputBorder.none)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Address',
                            style: TextStyle(
                                color: Colours.text,
                                fontSize: Dimens.font_sp15)),
                        Gaps.hGap16,
                        Expanded(
                          child: Text(
                            _authModel.memberAddress.nullSafe,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ))
              ])),
              Gaps.vGap24,
              MyDecoratedButton(
                  onPressed: uploadInfo, text: 'Continue', radius: 24)
            ]));
  }

  Future<void> uploadInfo() async {
    final String job = _jobController.text;

    if (job.isEmpty) {
      ToastUtils.show('The Occupation cannot be empty');
      return;
    }

    final String religion = _religionController.text;

    if (religion.isEmpty) {
      ToastUtils.show('The religion cannot be empty');
      return;
    }

    final String revenue = _revenueController.text;

    if (revenue.isEmpty) {
      ToastUtils.show('The revenue cannot be empty');
      return;
    }

    final String email = _emailController.text;

    if (email.isEmpty) {
      ToastUtils.show('The email cannot be empty');
      return;
    }

    final Map<String, dynamic> tmp = {
      'modifyIdCardName': _authModel.adCardOcrName,
      'modifyPanName': _authModel.panOcrName,
      'panNumber': _authModel.panNo,
      'idCardNumber': _authModel.adCardNo,
      'birthday': _authModel.birthday,
      'is_marriage': _marriedValue == 'Married' ? 1 : 0,
      'job': job,
      'religion': religion,
      'income': revenue,
      'gender': _authModel.sex,
      'pin': _authModel.memberPin,
      'address': _authModel.memberAddress,
      'email': email,
    };

    ToastUtils.showLoading();
    final data = await DioUtils.instance.client
        .updateAdJustInfo(tenantId: '1', info: tmp);
    if (data.code == 0 && context.mounted) {
      ToastUtils.cancelToast();
      final isBack = await Navigator.maybePop(context);
      if (!isBack) {
        await SystemNavigator.pop();
      }
    }
  }
}
