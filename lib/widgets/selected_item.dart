import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';

import '../res/gaps.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    super.key,
    this.leading,
    this.trailing,
    this.onTap,
    required this.title,
    this.titleStyle,
    this.content = '',
    this.textAlign = TextAlign.start,
    this.style,
    this.showLine = false,
  });

  final Widget? leading;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final String title;
  final TextStyle? titleStyle;
  final String content;
  final TextAlign textAlign;
  final TextStyle? style;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        onTap: onTap,
        splashColor: Colours.app_main_light_bg,
        child: Container(
          height: 50.0,
          margin: const EdgeInsets.only(right: 8.0, left: 16.0),
          width: double.infinity,
          decoration: showLine
              ? BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(context,
                        width: 0.6, color: Colours.line),
                  ),
                )
              : null,
          child: Row(
            children: <Widget>[
              if (leading != null) ...[leading!, Gaps.hGap10] else Gaps.empty,
              Text(title,
                  style: titleStyle != null
                      ? titleStyle!
                      : const TextStyle(
                          color: Colours.text, fontSize: Dimens.font_sp15)),
              Gaps.hGap16,
              Expanded(
                child: Text(
                  content,
                  maxLines: 2,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: style ??
                      const TextStyle(
                          color: Colours.text_regular,
                          fontSize: Dimens.font_sp14),
                ),
              ),
              Gaps.hGap8,
              if (trailing != null) ...[trailing!, Gaps.hGap8] else
                const Icon(Icons.arrow_forward_ios,
                    color: Colours.app_main, size: 15)
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedContentItem extends StatelessWidget {
  const SelectedContentItem({
    super.key,
    this.onTap,
    this.showLine = false,
    required this.child,
    this.radius,
    this.padding,
  });

  final Widget child;
  final GestureTapCallback? onTap;
  final bool showLine;
  final double? radius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius:
            radius != null ? BorderRadius.all(Radius.circular(radius!)) : null,
        onTap: onTap,
        splashColor: Colours.app_main_light_bg,
        child: Container(
          padding: padding,
          decoration: showLine
              ? BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(context,
                        width: 0.6, color: Colours.line),
                  ),
                )
              : null,
          child: child,
        ),
      ),
    );
  }
}
