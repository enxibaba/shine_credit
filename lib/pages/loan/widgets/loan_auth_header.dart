import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/widgets/coupon_shape_border.dart';
import 'package:shine_credit/widgets/load_image.dart';

class LoanAuthHeader extends StatelessWidget {
  const LoanAuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CouponShapeBorder(
          circleSize: 28, radiusBorder: 10, topMargin: 166),
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.26),
      color: Colors.white,
      elevation: 2,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 15),
        width: MediaQuery.of(context).size.width - 32,
        height: 296,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('I WANT',
                style: TextStyle(
                    fontSize: Dimens.font_sp15,
                    fontWeight: FontWeight.bold,
                    color: Colours.app_main)),
            Gaps.vGap15,
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colours.app_main_light_bg,
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    onTap: () {},
                    splashColor: Colours.button_disabled,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colours.app_main,
                            ),
                            width: 46,
                            height: 46,
                            child: const LoadAssetImage(
                              'home/loan_wallet_icon',
                              width: 38,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          '3000.00',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                        Gaps.hGap15,
                        const LoadAssetImage('home/arrow_forward_right',
                            fit: BoxFit.fill, width: 20, height: 20),
                        Gaps.hGap15,
                      ],
                    ),
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Tenure',
                        style: TextStyle(
                            fontSize: Dimens.font_sp15,
                            color: Colours.text_gray)),
                    Spacer(),
                    Text('7 Days',
                        style: TextStyle(
                            color: Colours.text,
                            fontSize: Dimens.font_sp15,
                            fontWeight: FontWeight.bold)),
                    Gaps.hGap15,
                    LoadAssetImage('home/arrow_forward_right',
                        fit: BoxFit.fill, width: 20, height: 20),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 31, right: 15, bottom: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Amount Received',
                            style:
                                TextStyle(color: Colours.text, fontSize: 15)),
                        Spacer(),
                        Text('₹ 1860',
                            style: TextStyle(
                                color: Colours.text_gray, fontSize: 16)),
                      ],
                    ),
                    Gaps.vGap10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Repayment Date',
                            style:
                                TextStyle(color: Colours.text, fontSize: 15)),
                        Spacer(),
                        Text('27-02-2023',
                            style: TextStyle(
                                color: Colours.text_gray, fontSize: 16)),
                      ],
                    ),
                    Gaps.vGap10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Amount Received',
                            style:
                                TextStyle(color: Colours.text, fontSize: 15)),
                        Spacer(),
                        Text('0%',
                            style: TextStyle(
                                color: Colours.text_gray, fontSize: 16)),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
