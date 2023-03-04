import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';

class LoanPage extends ConsumerStatefulWidget {
  const LoanPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanPageState();
}

class _LoanPageState extends ConsumerState<LoanPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 设置状态栏Icon 颜色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_gray,
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Container(
                  color: Colours.app_main,
                  height: MediaQuery.of(context).padding.top,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: AspectRatio(
                        aspectRatio: 18 / 11.2,
                        child: LoadAssetImage('login/login_bg',
                            width: double.infinity,
                            fit: BoxFit.fill,
                            format: ImageFormat.webp),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      child: Column(
                        children: const [
                          Text('Loan Amount',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp18,
                                  color: Colors.white)),
                          Gaps.vGap15,
                          Text('₹ 50000',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.white)),
                          Gaps.vGap15,
                        ],
                      ),
                    ),
                    MyCard(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Total Interest@0.892%p.m.',
                                  style: TextStyle(
                                      color: Colours.text_regular,
                                      fontSize: Dimens.font_sp16),
                                ),
                                Gaps.vGap15,
                                Text('Annualized Interest Rate:3%p.a.',
                                    style: TextStyle(
                                        color: Colours.text_regular,
                                        fontSize: Dimens.font_sp12)),
                              ],
                            ),
                            const Text('₹ 50000',
                                style: TextStyle(
                                    color: Colours.text_regular,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.font_sp16))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Gaps.vGap16,
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colours.app_main),
                      color: Colours.app_main_bg,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('TRANSFER TO BANK',
                              style: TextStyle(
                                  color: Colours.text_regular,
                                  fontSize: Dimens.font_sp12)),
                          Gaps.vGap10,
                          Text('₹ 50000',
                              style: TextStyle(
                                  color: Colours.text,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23)),
                        ],
                      ),
                      const SizedBox(
                        width: 0.5,
                        height: 82,
                        child: ColoredBox(
                          color: Colours.text_gray,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text('Tenure',
                              style: TextStyle(
                                  color: Colours.text_regular,
                                  fontSize: Dimens.font_sp12)),
                          Gaps.vGap10,
                          Text('12 months',
                              style: TextStyle(
                                  color: Colours.text,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23)),
                        ],
                      )
                    ],
                  ),
                ),
                const Expanded(child: ColoredBox(color: Colours.bg_gray)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: MyDecoratedButton(
                      radius: 24,
                      text: 'Request',
                      onPressed: () => const LoginRoute().go(context)),
                ),
                Gaps.vGap24,
              ],
            ),
          )
        ]));
  }
}
