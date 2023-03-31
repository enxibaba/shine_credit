import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/widgets/load_image.dart';

class LoanTipsBar extends StatelessWidget {
  LoanTipsBar({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;
  final int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 180;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.only(left: 15),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colours.app_main_light_bg,
        ),
        height: 50,
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Flexible(
            child: Row(
              children: [
                const LoadAssetImage('home/loan_tips_icon',
                    fit: BoxFit.fill, width: 43, height: 40),
                Gaps.hGap10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime? time) {
                        if (time == null) {
                          return const Text('time over',
                              style: TextStyle(
                                  color: Colours.app_main,
                                  fontSize: Dimens.font_sp15));
                        }
                        return Text(
                            '0${time.min ?? 0}:${time.sec! > 9 ? time.sec : '0${time.sec}'}',
                            style: const TextStyle(
                                color: Colours.app_main,
                                fontSize: Dimens.font_sp15));
                      },
                    ),
                    Gaps.vGap4,
                    const Text('99% approve',
                        style: TextStyle(
                            color: Colours.app_main,
                            fontSize: Dimens.font_sp12))
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
            child: ColoredBox(
              color: Colours.app_main,
              child: Center(
                child: Text('Loan Now ',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp18)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
