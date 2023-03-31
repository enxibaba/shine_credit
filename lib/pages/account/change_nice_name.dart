import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_scroll_view.dart';

class ChangeNickNamePage extends StatefulWidget {
  const ChangeNickNamePage({super.key, required this.name});

  final String name;

  @override
  State<ChangeNickNamePage> createState() => _ChangeNickNamePageState();
}

class _ChangeNickNamePageState extends State<ChangeNickNamePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  Future<void> _changeNiceName() async {
    final String name = _controller.text;

    if (name.isEmpty) {
      ToastUtils.show('NickName cannot be empty');
      return;
    }

    if (name == widget.name) {
      ToastUtils.show('NickName cannot be the same as the original one');
      return;
    }

    ToastUtils.showLoading(msg: 'Updating...');
    try {
      final result = await DioUtils.instance.client
          .updateNickName(tenantId: '1', body: {'nickName': _controller.text});

      if (result.code == 0) {
        ToastUtils.show('update Success');
        if (context.mounted) {
          final isBack = await Navigator.maybePop(context);
          if (!isBack) {
            await SystemNavigator.pop();
          }
        }
      }
    } finally {
      ToastUtils.cancelToast();
    }
  }

  @override
  void initState() {
    _controller.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          backgroundColor: Colours.app_main,
          centerTitle: 'Change NickName',
          actionWidget: MyButton(
            fontSize: Dimens.font_sp16,
            minWidth: null,
            text: 'OK',
            textColor: Colors.white,
            backgroundColor: Colors.transparent,
            onPressed: _changeNiceName,
          ),
        ),
        body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[
            _nodeText1,
          ]),
          padding: const EdgeInsets.all(15),
          children: [
            NickNameTextField(
              hintText: 'Please enter your nickname',
              controller: _controller,
              focusNode: _nodeText1,
            ),
          ],
        ));
  }
}

class NickNameTextField extends StatelessWidget {
  const NickNameTextField({
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('NICK NAME',
              style: TextStyle(fontSize: 15, color: Colours.text)),
          SizedBox(
            width: 200,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: autoFocus,
              keyboardType: keyboardType,
              maxLength: maxLength,
              obscureText: isInputPwd,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
              ],
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 15),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
