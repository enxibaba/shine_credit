import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/widgets/load_image.dart';

class LoanTipsBar extends StatelessWidget {
  const LoanTipsBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('02:00',
                      style: TextStyle(
                          color: Colours.app_main, fontSize: Dimens.font_sp15)),
                  Text('99% approve',
                      style: TextStyle(
                          color: Colours.app_main, fontSize: Dimens.font_sp12))
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
    );
  }
}
