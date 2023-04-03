import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/device_utils.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';

/// 登录模块的输入框封装
class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.controller,
      this.maxLength = 16,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.hintText = '',
      this.focusNode,
      this.isInputPwd = false,
      this.getVCode,
      this.keyName});

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode? focusNode;
  final bool isInputPwd;
  final Future<bool> Function()? getVCode;

  /// 用于集成测试寻找widget
  final String? keyName;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  late int _currentSecond;
  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isNotEmpty;

    /// 监听输入焦点改变
    widget.focusNode?.addListener(isShowDeleteButon);
    widget.controller.addListener(isShowDeleteButon);

    super.initState();
  }

  void isShowDeleteButon() {
    final bool isFocus = widget.focusNode?.hasFocus ?? false;
    final bool isNotEmpty = widget.controller.text.isNotEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if ((isFocus && isNotEmpty) != _isShowDelete) {
      setState(() {
        _isShowDelete = isFocus && isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller.removeListener(isShowDeleteButon);
    widget.focusNode?.removeListener(isShowDeleteButon);
    super.dispose();
  }

  Future<dynamic> _getVCode() async {
    final bool isSuccess = await widget.getVCode!();
    if (isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });
      _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i)
          .take(_second)
          .listen((int i) {
        AppUtils.log.d(i);
        setState(() {
          _currentSecond = _second - i - 1;
          AppUtils.log.d(_currentSecond);
          _clickable = _currentSecond < 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;

    Widget textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      // 数字、手机号限制格式为0到9， 密码限制不包含汉字
      inputFormatters: (widget.keyboardType == TextInputType.number ||
              widget.keyboardType == TextInputType.phone)
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))],
      decoration: InputDecoration(
        prefix: widget.keyName == 'phone'
            ? const SizedBox(
                width: 50.0,
              )
            : Gaps.hGap15,
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: widget.hintText,
        counterText: '',
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colours.app_main,
            width: 0.5,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colours.text,
            width: 0.5,
          ),
        ),
      ),
    );

    /// 个别Android机型（华为、vivo）的密码安全键盘不弹出问题（已知小米正常），临时修复方法：https://github.com/flutter/flutter/issues/68571 (issues/61446)
    /// 怀疑是安全键盘与三方输入法之间的切换冲突问题。
    if (Device.isAndroid) {
      textField = Listener(
        onPointerDown: (e) =>
            FocusScope.of(context).requestFocus(widget.focusNode),
        child: textField,
      );
    }

    Widget? clearButton;

    if (_isShowDelete) {
      clearButton = GestureDetector(
        child: LoadAssetImage(
          'login/icon_delete',
          key: Key('${widget.keyName}_delete'),
          width: 20.0,
          height: 20.0,
        ),
        onTap: () => widget.controller.text = '',
      );
    }

    late Widget pwdVisible;
    if (widget.isInputPwd) {
      pwdVisible = GestureDetector(
        child: LoadAssetImage(
          _isShowPwd ? 'login/icon_display' : 'login/icon_hide',
          key: Key('${widget.keyName}_showPwd'),
          width: 20.0,
          height: 20.0,
          format: _isShowPwd ? ImageFormat.svg : ImageFormat.png,
        ),
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
      );
    }

    late Widget getVCodeButton;
    if (widget.getVCode != null) {
      getVCodeButton = InkWell(
        onTap: _clickable ? _getVCode : null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 25,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 0.5, //宽度
                color: Colours.text_gray, //边框颜色
              ),
            ),
          ),
          child: Text(
            _clickable ? 'otp' : '$_currentSecond s',
            style: const TextStyle(
                color: Colours.app_main, fontSize: Dimens.font_sp15),
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (widget.keyName == 'phone')
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 50.0,
              alignment: Alignment.center,
              child: Text(
                '+91',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.font_sp15,
                  color: isDark ? Colours.dark_text : Colours.text,
                ),
              ),
            ),
          ),
        textField,
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// _isShowDelete参数动态变化，为了不破坏树结构使用Visibility，false时放一个空Widget。
              /// 对于其他参数，为初始配置参数，基本可以确定树结构，就不做空Widget处理。
              Visibility(
                visible: _isShowDelete,
                child: clearButton ?? Gaps.empty,
              ),
              if (widget.isInputPwd) Gaps.hGap8,
              if (widget.isInputPwd) pwdVisible,
              if (widget.getVCode != null) Gaps.hGap8,
              if (widget.getVCode != null) getVCodeButton,
              Gaps.hGap15
            ],
          ),
        )
      ],
    );
  }
}
