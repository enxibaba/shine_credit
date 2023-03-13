import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/utils/image_utils.dart';
import '../res/dimens.dart';
import '../res/gaps.dart';
import '../utils/theme_utils.dart';

import 'load_image.dart';

class StateLayout extends StatelessWidget {
  const StateLayout({super.key, required this.type, this.hintText});

  final StateType type;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (type == StateType.loading)
          Column(
            children: const [
              Gaps.vGap24,
              CupertinoActivityIndicator(radius: 26.0),
              Gaps.vGap16,
              Text('Please wait a moment...',
                  style: TextStyle(
                      fontSize: Dimens.font_sp16, color: Colours.text_gray))
            ],
          )
        else if (type != StateType.empty)
          Opacity(
            opacity: context.isDark ? 0.5 : 1,
            child: LoadAssetImage(
              'state/${type.img}',
              width: 120,
              format: ImageFormat.png,
            ),
          ),
        const SizedBox(
          width: double.infinity,
          height: Dimens.gap_dp16,
        ),
        Text(
          hintText ?? type.hintText,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap50,
      ],
    );
  }
}

enum StateType {
  /// 无网络
  network,

  /// 加载中
  loading,

  /// 空
  empty
}

extension StateTypeExtension on StateType {
  String get img => <String>[
        'zwwl',
        '',
        '',
      ][index];

  String get hintText => <String>['无网络连接', '', ''][index];
}