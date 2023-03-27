import 'package:flutter/material.dart';
import 'package:shine_credit/entities/loan_record_detail.dart';
import 'package:shine_credit/net/http_utils.dart';

import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';

class RepayMentDetail extends StatefulWidget {
  const RepayMentDetail({super.key, required this.id});

  final String id;

  @override
  State<RepayMentDetail> createState() => _RepayMentDetailState();
}

class _RepayMentDetailState extends State<RepayMentDetail> {
  @override
  void initState() {
    super.initState();
  }

  Future<LoanRecordDetail?> requstData() async {
    final data = await DioUtils.instance.client
        .getRepayMentDetail(tenantId: '1', body: {'orderId': widget.id});
    return data.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          centerTitle: 'Repayment details',
          backgroundColor: Colours.app_main,
        ),
        backgroundColor: Colours.bg_gray_,
        body: SafeArea(
            child: FutureBuilderWidget(
                futureFunc: requstData,
                builder: (context, data) {
                  return CustomScrollView(slivers: [
                    SliverFillRemaining(
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(children: [
                              MyCard(
                                  radius: 10,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colours.app_main,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(data?.productName ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Dimens.font_sp18)),
                                              Text(data?.statusText ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Dimens.font_sp18)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Repay amount',
                                                  style: TextStyle(
                                                      color: Colours.text,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Dimens.font_sp16)),
                                              Text('₹${data?.repayAmount}',
                                                  style: const TextStyle(
                                                      color: Colours.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Dimens.font_sp18)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 15),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colours.app_main_bg),
                                            child: Column(
                                              children: [
                                                RepayMentInfoItem(
                                                    title: 'Loan Amount',
                                                    content:
                                                        '₹${data?.loanAmount}'),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Divider(
                                                      color: Colors.white,
                                                      height: 0.5),
                                                ),
                                                RepayMentInfoItem(
                                                    title: 'Repaid Date',
                                                    content:
                                                        '₹${data?.repaidDate}'),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Divider(
                                                      color: Colors.white,
                                                      height: 0.5),
                                                ),
                                                RepayMentInfoItem(
                                                    title: 'Overdue Amount',
                                                    content:
                                                        '₹${data?.overdueAmount}'),
                                              ],
                                            )),
                                      ])),
                              const Expanded(
                                  child: ColoredBox(color: Colours.bg_gray_)),
                              MyDecoratedButton(
                                  onPressed: () => {},
                                  text: 'Confirmed payment',
                                  radius: 24),
                              Gaps.vGap15,
                              OutlinedButton(
                                  style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: Colours.app_main)),
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24))))),
                                  onPressed: () => {},
                                  child: const Text('Detay payment',
                                      style: TextStyle(
                                          color: Colours.app_main,
                                          fontSize: Dimens.font_sp18)))
                            ])))
                  ]);
                })));
  }
}

class RepayMentInfoItem extends StatelessWidget {
  const RepayMentInfoItem({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black, fontSize: Dimens.font_sp15)),
          Text(content,
              style: const TextStyle(
                  color: Colours.text_gray, fontSize: Dimens.font_sp15)),
        ],
      ),
    );
  }
}
