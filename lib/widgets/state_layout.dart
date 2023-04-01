import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_button.dart';

class StateLayout extends StatelessWidget {
  const StateLayout(
      {super.key, required this.type, this.hintText, this.retryCallback});

  final StateType type;
  final String? hintText;
  final VoidCallback? retryCallback;

  @override
  Widget build(BuildContext context) {
    if (type == StateType.loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Gaps.vGap24,
            CupertinoActivityIndicator(radius: 26.0),
            Gaps.vGap16,
            Text('Please wait a moment...',
                style: TextStyle(
                    fontSize: Dimens.font_sp16, color: Colours.text_gray))
          ],
        ),
      );
    } else if (type == StateType.empty) {
      return Center(
          child: Column(
        children: [
          LoadAssetImage(
            'state/${type.img}',
            width: 120,
            format: ImageFormat.png,
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
          )
        ],
      ));
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gaps.vGap16,
          const Text('Some Error, Please Retry',
              style: TextStyle(fontSize: 16)),
          Gaps.vGap16,
          MyDecoratedButton(
            radius: 24,
            minWidth: 100,
            onPressed: retryCallback,
            text: 'Retry',
          ),
        ],
      ));
    }
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

  String get hintText => <String>['Some error', '', ''][index];
}
