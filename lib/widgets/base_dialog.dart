import 'package:flutter/material.dart';

import '../res/gaps.dart';
import '../res/styles.dart';
import '../utils/device_utils.dart';
import 'my_button.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {super.key,
      this.title,
      this.onPressed,
      this.onCancel,
      this.hiddenTitle = false,
      required this.child});

  final String? title;
  final VoidCallback? onPressed;
  final VoidCallback? onCancel;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    final Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          hiddenTitle ? '' : title ?? '',
          style: TextStyles.textBold18,
        ),
      ),
    );

    final Widget bottomButton = Row(
      children: <Widget>[
        _DialogButton(
          text: 'sure',
          textColor: Theme.of(context).primaryColor,
          onPressed: onPressed,
        ),
      ],
    );

    final Widget content = Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap24,
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap8,
          Gaps.line,
          bottomButton,
        ],
      ),
    );

    final Widget body = MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Center(
        child: SizedBox(
          width: 270.0,
          child: content,
        ),
      ),
    );

    /// Android 11添加了键盘弹出动画，这与我添加的过渡动画冲突（原先iOS、Android 没有相关过渡动画，相关问题跟踪：https://github.com/flutter/flutter/issues/19279）。
    /// 因为在Android 11上，viewInsets的值在键盘弹出过程中是变化的（以前只有开始结束的值）。
    /// 所以解决方法就是在Android 11及以上系统中使用Padding代替AnimatedPadding。

    if (Device.getAndroidSdkInt() >= 30) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: body,
      );
    } else {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic, // easeOutQuad
        child: body,
      );
    }
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.text,
    this.textColor,
    this.onPressed,
  });

  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyButton(
        text: text,
        textColor: textColor,
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
