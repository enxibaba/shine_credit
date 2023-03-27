// ignore_for_file: prefer_final_locals, unused_field, avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/loan_record_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/res/styles.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/list_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/my_refresh_list.dart';
import 'package:shine_credit/widgets/selected_item.dart';
import 'package:shine_credit/widgets/state_layout.dart';

class RepayMentPage extends ConsumerStatefulWidget {
  const RepayMentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepayMentPageState();
}

class LoanRecordSession {
  LoanRecordSession(this.title, this.list);

  final String title;
  final List<LoanRecordModel> list;
}

class _RepayMentPageState extends ConsumerState<RepayMentPage>
    with AutomaticKeepAliveClientMixin<RepayMentPage> {
  final int _page = 1;
  final int _maxPage = 3;
  final StateType _stateType = StateType.loading;

  List<LoanRecordSession> _list = [];

  Future<void> _onRefresh() async {
    final data = await DioUtils.instance.client.getLoanRecord(tenantId: '1');

    // 把 List<LoanRecordModel>  转换成 List<LoanRecordSession>
    final list = <LoanRecordSession>[];
    for (final element in data.data) {
      final session = list
          .firstWhereOrNull((element2) => element2.title == element.applyTime);
      if (session == null) {
        list.add(LoanRecordSession(element.applyTime.nullSafe, [element]));
      } else {
        session.list.add(element);
      }
    }
    setState(() {
      _list = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colours.bg_gray_,
        appBar: const MyAppBar(
          isBack: false,
          centerTitle: 'Repayment',
          backgroundColor: Colours.app_main,
        ),
        body: RefreshListView(
            key: const Key('repayment_page'),
            emptyWidget: const RepayMentEmpty(),
            padding: const EdgeInsets.all(15),
            stateType: _stateType,
            hasMore: _page < _maxPage,
            itemCount: _list.length,
            onRefresh: _onRefresh,
            itemBuilder: (_, index) {
              return RepayMentItem(
                  item: _list[index],
                  callback: (item) =>
                      RepayMentDetailRoute(item.orderNumber.nullSafe)
                          .push(context));
            }));
  }

  @override
  bool get wantKeepAlive => true;
}

class RepayMentItem extends StatelessWidget {
  const RepayMentItem({
    super.key,
    required this.callback,
    required this.item,
  });

  final LoanRecordSession item;
  final GenericTypesCallback<LoanRecordModel> callback;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        radius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colours.app_main,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(item.title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: Dimens.font_sp14)),
            ),
            ...List.generate(
                item.list.length,
                (index) => SelectedContentItem(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 20),
                    onTap: () => callback(item.list[index]),
                    showLine: item.list.length > index + 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.list[index].productName.nullSafe,
                              style: const TextStyle(
                                  color: Colours.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.font_sp15),
                            ),
                            Text(
                              item.list[index].statusText,
                              style: TextStyle(
                                  color: item.list[index].statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.font_sp12),
                            ),
                          ],
                        ),
                        Gaps.vGap15,
                        // 订单号
                        Text(
                          'Order Number：${item.list[index].orderNumber}',
                          style: const TextStyle(
                              color: Colours.text_regular,
                              fontSize: Dimens.font_sp15),
                        ),
                        Gaps.vGap5,
                        Text(
                          'LoanAmount：₹${item.list[index].loanAmount}',
                          style: const TextStyle(
                              color: Colours.text_regular,
                              fontSize: Dimens.font_sp15),
                        ),
                        // 金额
                      ],
                    )))
          ],
        ));
  }
}

class RepayMentEmpty extends ConsumerWidget {
  const RepayMentEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const LoadAssetImage(
        'home/repayment_empty',
        width: 100,
        height: 100,
      ),
      Gaps.vGap15,
      const Text(
        'NO borrowing record',
        style: TextStyles.textBold24,
      ),
      Gaps.vGap24,
      MyDecoratedButton(
          minWidth: 200,
          onPressed: () => ref.read(homeProvider.notifier).selectIndex(0),
          text: 'Get loan',
          radius: 24)
    ]));
  }
}
