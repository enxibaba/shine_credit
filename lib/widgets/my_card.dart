import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/utils/theme_utils.dart';

class MyCard extends StatelessWidget {
  const MyCard(
      {super.key,
      required this.child,
      this.color,
      this.shadowColor,
      this.margin});

  final Widget child;
  final Color? color;
  final Color? shadowColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    final Color backgroundColor =
        color ?? (isDark ? Colours.dark_bg_gray_ : Colors.white);
    final Color sColor =
        isDark ? Colors.transparent : (shadowColor ?? const Color(0x80DCE7FA));

    return Container(
      margin: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: sColor, offset: const Offset(0.0, 2.0), blurRadius: 8.0),
          ],
        ),
        child: child,
      ),
    );
  }
}
