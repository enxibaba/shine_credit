import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_scroll_view.dart';
import 'package:sp_util/sp_util.dart';

class ModifyPwdPage extends StatefulWidget {
  const ModifyPwdPage({super.key});

  @override
  State<ModifyPwdPage> createState() => _ModifyPwdPageState();
}

class _ModifyPwdPageState extends State<ModifyPwdPage> {
  //定义一个controller
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();

  late bool hasSetPwd;

  Future<void> _setPwd() async {
    final String oldPwd = _oldPasswordController.text.trim();
    final String password = _passwordController.text.trim();
    final String again = _passwordAgainController.text.trim();

    if (hasSetPwd && oldPwd.isEmpty) {
      ToastUtils.show('original password cannot be empty');
      return;
    }

    if (password.isEmpty) {
      ToastUtils.show('password cannot be empty');
      return;
    }

    if (password.length < 4) {
      ToastUtils.show('The password must be between 4 and 16 digits long');
      return;
    }

    if (again.isEmpty) {
      ToastUtils.show('confirm password cannot be empty');
      return;
    }

    if (again != password) {
      ToastUtils.show('The two passwords were entered inconsistently');
      return;
    }

    ToastUtils.showLoading();

    try {
      final data =
          await DioUtils.instance.client.settingPwd(tenantId: '1', body: {
        'password': password,
        'oldPassword': oldPwd ?? '123456',
      });

      if (data.code == 0) {
        ToastUtils.show('update Success');
        SpUtil.putInt(Constant.initPwdStatus, 1);
        if (context.mounted) {
          final isBack = await Navigator.maybePop(context);
          if (!isBack) {
            await SystemNavigator.pop();
          }
        }
      }
    } catch (_) {
      ToastUtils.cancelToast();
    }
  }

  @override
  void initState() {
    hasSetPwd = SpUtil.getInt(Constant.initPwdStatus)! == 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          backgroundColor: Colours.app_main,
          centerTitle: 'Setting Password',
          actionWidget: MyButton(
            fontSize: Dimens.font_sp16,
            minWidth: null,
            text: 'OK',
            textColor: Colors.white,
            backgroundColor: Colors.transparent,
            onPressed: _setPwd,
          ),
        ),
        body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[
            if (hasSetPwd) _nodeText1,
            _nodeText2,
            _nodeText3,
          ]),
          padding: const EdgeInsets.all(15),
          children: [
            if (hasSetPwd)
              PwdTextField(
                hintText: 'Please enter old password',
                controller: _oldPasswordController,
                focusNode: _nodeText1,
              ),
            if (hasSetPwd) Gaps.vGap15,
            PwdTextField(
              hintText: 'Please enter new password',
              controller: _passwordController,
              focusNode: _nodeText2,
            ),
            Gaps.vGap15,
            PwdTextField(
              hintText: 'Please enter the password again',
              controller: _passwordAgainController,
              focusNode: _nodeText3,
            ),
          ],
        ));
  }
}

class PwdTextField extends StatelessWidget {
  const PwdTextField({
    super.key,
    required this.controller,
    this.maxLength = 16,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.isInputPwd = false,
  });

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode? focusNode;
  final bool isInputPwd;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5.0,
              color: Colors.black.withOpacity(0.06),
            ),
          ],
        ),
        child: TextField(
            focusNode: focusNode,
            maxLength: maxLength,
            obscureText: true,
            autofocus: autoFocus,
            controller: controller,
            textInputAction: TextInputAction.done,
            keyboardType: keyboardType,
            // 数字、手机号限制格式为0到9， 密码限制不包含汉字
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
            ],
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              hintText: hintText,
              counterText: '',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            )));
  }
}
