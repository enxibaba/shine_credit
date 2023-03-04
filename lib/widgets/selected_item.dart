import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';

import '../res/gaps.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    super.key,
    this.leading,
    this.onTap,
    required this.title,
    this.content = '',
    this.textAlign = TextAlign.start,
    this.style,
  });

  final Widget? leading;
  final GestureTapCallback? onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        onTap: onTap,
        splashColor: Theme.of(context).primaryColorLight,
        child: Container(
          height: 50.0,
          margin: const EdgeInsets.only(right: 8.0, left: 16.0),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              if (leading != null) ...[leading!, Gaps.hGap10] else Gaps.empty,
              Text(title,
                  style: const TextStyle(
                      color: Colours.text, fontSize: Dimens.font_sp15)),
              Gaps.hGap16,
              Expanded(
                child: Text(content,
                    maxLines: 2,
                    textAlign: textAlign,
                    overflow: TextOverflow.ellipsis,
                    style: style),
              ),
              Gaps.hGap8,
              const Icon(Icons.arrow_forward_ios,
                  color: Colours.app_main, size: 15)
            ],
          ),
        ),
      ),
    );
  }
}
