import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/change_notifier_manage.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_scroll_view.dart';

class ChangeNickNamePage extends StatefulWidget {
  const ChangeNickNamePage({super.key});

  @override
  State<ChangeNickNamePage> createState() => _ChangeNickNamePageState();
}

class _ChangeNickNamePageState extends State<ChangeNickNamePage>
    with ChangeNotifierMixin<ChangeNickNamePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _controller: callbacks,
      _nodeText1: null,
    };
  }

  void _verify() {
    final String name = _controller.text;

    bool clickable = true;
    if (name.isEmpty || name.length < 6) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _setPwd() {}

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
            onPressed: _clickable ? _setPwd : null,
          ),
        ),
        body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[
            _nodeText1,
          ]),
          padding: const EdgeInsets.all(15),
          children: [
            PwdTextField(
              hintText: 'Please enter your nickname',
              controller: _controller,
              focusNode: _nodeText1,
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
