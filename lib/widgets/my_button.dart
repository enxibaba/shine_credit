// ignore_for_file: dead_code

import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/dimens.dart';
import '../utils/theme_utils.dart';

class MyDecoratedButton extends StatelessWidget {
  const MyDecoratedButton({
    super.key,
    this.text = '',
    this.fontSize = Dimens.font_sp18,
    this.textColor,
    this.disabledTextColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 2.0,
    this.side = BorderSide.none,
    this.gradient = const LinearGradient(colors: [
      Colours.gradient_blue,
      Colours.app_main,
    ]),
    required this.onPressed,
  });

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final LinearGradient gradient;
  final double? minHeight;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            // 文字颜色
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return disabledTextColor ??
                      (isDark
                          ? Colours.dark_text_disabled
                          : Colours.text_disabled);
                }
                return textColor ??
                    (isDark ? Colours.dark_button_text : Colors.white);
              },
            ),
            // 水波纹
            overlayColor: MaterialStateProperty.resolveWith((states) {
              return (textColor ??
                      (isDark ? Colours.dark_button_text : Colors.white))
                  .withOpacity(0.12);
            }),
            // 按钮最小大小
            minimumSize: (minWidth == null || minHeight == null)
                ? null
                : MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
            side: MaterialStateProperty.all<BorderSide>(side),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          )),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.text = '',
    this.fontSize = Dimens.font_sp18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 2.0,
    this.side = BorderSide.none,
    required this.onPressed,
  });

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? minHeight;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // 文字颜色
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledTextColor ??
                    (isDark
                        ? Colours.dark_text_disabled
                        : Colours.text_disabled);
              }
              return textColor ??
                  (isDark ? Colours.dark_button_text : Colors.white);
            },
          ),
          // 背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledBackgroundColor ??
                  (isDark
                      ? Colours.dark_button_disabled
                      : Colours.button_disabled);
            }
            return backgroundColor ??
                (isDark ? Colours.dark_app_main : Colours.app_main);
          }),
          // 水波纹
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return (textColor ??
                    (isDark ? Colours.dark_button_text : Colors.white))
                .withOpacity(0.12);
          }),
          // 按钮最小大小
          minimumSize: (minWidth == null || minHeight == null)
              ? null
              : MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(side),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        ));
  }
}
