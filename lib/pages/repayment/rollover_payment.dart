import 'package:flutter/material.dart';
import 'package:shine_credit/entities/rollover_pay_ment_model.dart';
import 'package:shine_credit/entities/uri_info.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';

class RolloverPayMent extends StatefulWidget {
  const RolloverPayMent({super.key, required this.id});

  final String id;

  @override
  State<RolloverPayMent> createState() => _RolloverPayMentState();
}

class _RolloverPayMentState extends State<RolloverPayMent> with RouteAware {
  final GlobalKey<FutureBuilderWidgetState<dynamic>> rolloverPayMentFreshenKey =
      GlobalKey(debugLabel: 'rolloverPayMentFreshenKey');

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    rolloverPayMentFreshenKey.currentState?.retry();
  }

  Future<RolloverPayMentModel?> requestData() async {
    final data = await DioUtils.instance.client
        .rolloverPayMentDetail(tenantId: '1', body: {'orderId': widget.id});
    return data.data;
  }

  Future<void> repaymentRequest() async {
    ToastUtils.showLoading();

    try {
      final data = await DioUtils.instance.client.initiateRepayment(
          tenantId: '1', body: {'orderId': widget.id, 'type': 2});
      final url = data.data.fileUrl ?? '';

      if (url.isNotEmpty && context.mounted) {
        final info = UriInfo('Payment', url);
        WebViewRoute(info.encodingJsonString()).push(context);
      }
    } catch (e) {
      AppUtils.log.e(e);
    } finally {
      ToastUtils.cancelToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          centerTitle: 'Rollover',
          backgroundColor: Colours.app_main,
        ),
        body: SafeArea(
            child: FutureBuilderWidget(
                key: rolloverPayMentFreshenKey,
                futureFunc: requestData,
                builder: (context, data) {
                  return CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: MyCard(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Container(
                                  decoration: const BoxDecoration(
                                    color: Colours.app_main,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Column(children: [
                                    const Text(
                                      'Total repayment amount',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gaps.vGap10,
                                    Text('₹${data?.repaymentAmount}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold)),
                                    RolloverListItem(
                                        title: 'Loan Amount',
                                        content: '₹${data?.loanAmount}'),
                                    RolloverListItem(
                                        title: 'Expiration Time',
                                        content: data?.expirationTime ?? ''),
                                    RolloverListItem(
                                        title: 'Extend Payment Period',
                                        content:
                                            '${data?.extendPaymentPeriod} Days'),
                                    RolloverListItem(
                                        title: 'Due Time After Extension',
                                        content:
                                            data?.dueTimeAfterExtension ?? ''),
                                    RolloverListItem(
                                        title: 'Overdue Amount',
                                        content: '₹${data?.overdueAmount}'),
                                    RolloverListItem(
                                        title: 'Extend Repayment Fee',
                                        content: '₹${data?.extendRepaymentFee}',
                                        isShowLine: false),
                                  ])),
                            ],
                          )),
                    ),
                    SliverFillRemaining(
                        child: Padding(
                      padding: const EdgeInsetsDirectional.all(16),
                      child: MyDecoratedButton(
                        onPressed: repaymentRequest,
                        text: 'Immediate repayment',
                      ),
                    ))
                  ]);
                })));
  }
}

class RolloverListItem extends StatelessWidget {
  const RolloverListItem({
    super.key,
    required this.title,
    required this.content,
    this.isShowLine = true,
  });

  final String title;
  final String content;
  final bool isShowLine;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: isShowLine
            ? const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colours.line, width: 0.5)),
              )
            : null,
        padding: const EdgeInsets.all(15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: const TextStyle(
                color: Colours.text,
                fontSize: 15,
              )),
          Text(content,
              style: const TextStyle(
                color: Colours.text_gray,
                fontSize: 15,
              )),
        ]));
  }
}
