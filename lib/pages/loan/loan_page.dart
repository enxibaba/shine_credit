import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/no_auth_loan_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/state_layout.dart';

class LoanPage extends ConsumerStatefulWidget {
  const LoanPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanPageState();
}

class _LoanPageState extends ConsumerState<LoanPage>
    with AutomaticKeepAliveClientMixin<LoanPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 设置状态栏Icon 颜色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
  }

  Future<NoAuthLoanModel?> requestData() async {
    final info = await DioUtils.instance.client.loanNoAuthInfo(tenantId: '1');
    return info.data;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colours.bg_gray,
        body: FutureBuilder(
          builder:
              (BuildContext context, AsyncSnapshot<NoAuthLoanModel?> snapshot) {
            if (snapshot.hasData) {
              return _buildBody(snapshot.data!);
            } else {
              return StateLayout(
                  type: snapshot.hasError
                      ? StateType.network
                      : StateType.loading);
            }
          },
          future: requestData(),
        ));
  }

  Widget _buildBody(NoAuthLoanModel noAuthLoanModel) {
    return CustomScrollView(slivers: [
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
                    aspectRatio: 360 / 224,
                    child: LoadAssetImage('home/home_bg',
                        width: double.infinity,
                        fit: BoxFit.fill,
                        format: ImageFormat.png),
                  ),
                ),
                Positioned(
                  top: 60,
                  child: Column(
                    children: const [
                      Text('Loan Amount',
                          style: TextStyle(
                              fontSize: Dimens.font_sp18, color: Colors.white)),
                      Gaps.vGap15,
                      Text('₹ 50000',
                          style: TextStyle(fontSize: 50, color: Colors.white)),
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
                          children: [
                            Text(
                              'Total Interest@${noAuthLoanModel.rate}p.m.',
                              style: const TextStyle(
                                  color: Colours.text_regular,
                                  fontSize: Dimens.font_sp16),
                            ),
                            Gaps.vGap15,
                            Text(
                                'Annualized Interest Rate:${noAuthLoanModel.serviceRate}p.a.',
                                style: const TextStyle(
                                    color: Colours.text_regular,
                                    fontSize: Dimens.font_sp12)),
                          ],
                        ),
                        Text('₹ ${noAuthLoanModel.totalInterest}',
                            style: const TextStyle(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colours.app_main),
                  color: Colours.app_main_bg,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('TRANSFER TO BANK',
                          style: TextStyle(
                              color: Colours.text_regular,
                              fontSize: Dimens.font_sp12)),
                      Gaps.vGap10,
                      Text('₹ ${noAuthLoanModel.receivedAmount}',
                          style: const TextStyle(
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
                    children: [
                      const Text('Tenure',
                          style: TextStyle(
                              color: Colours.text_regular,
                              fontSize: Dimens.font_sp12)),
                      Gaps.vGap10,
                      Text('${noAuthLoanModel.tenure}',
                          style: const TextStyle(
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
    ]);
  }
}
