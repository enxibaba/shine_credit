import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/entities/no_auth_loan_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/device_utils.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';

class LoanUnAuthPage extends ConsumerStatefulWidget {
  const LoanUnAuthPage(this.authConfigModel, {super.key});

  final AuthConfigModel? authConfigModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanUnAuthPageState();
}

class _LoanUnAuthPageState extends ConsumerState<LoanUnAuthPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Device.isAndroid) {
        final SystemUiOverlayStyle systemUiOverlayStyle =
            SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colours.app_main,
        );
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
  }

  Future<NoAuthLoanModel?> requestData() async {
    final info = await DioUtils.instance.client.loanNoAuthInfo(tenantId: '1');
    return info.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_gray,
        body: FutureBuilderWidget(
            futureFunc: requestData,
            builder: (context, data) {
              return _buildBody(data!);
            }));
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
                const Positioned(
                  top: 60,
                  child: Column(
                    children: [
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
                  radius: 24, text: 'Request', onPressed: _request),
            ),
            Gaps.vGap24,
          ],
        ),
      )
    ]);
  }

  void _request() {
    if (widget.authConfigModel != null) {
      /// go to auth view
      const LoanAutoRoute().push(context);
    } else {
      /// go to login
      const LoginRoute().go(context);
    }
  }
}
