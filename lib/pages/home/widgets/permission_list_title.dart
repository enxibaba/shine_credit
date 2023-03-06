import 'package:flutter/material.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/res/styles.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';

class PermissionListTitle extends StatelessWidget {
  const PermissionListTitle({
    super.key,
    required this.title,
    required this.tips,
    required this.icon,
  });

  final String icon;
  final String title;
  final String tips;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoadAssetImage(
          icon,
          width: 30,
          height: 30,
          format: ImageFormat.webp,
        ),
        Gaps.hGap16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.textBold14,
              ),
              Gaps.vGap4,
              Text(
                tips,
                style: TextStyles.textSize12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
