import 'package:flutter/material.dart';
import 'package:shine_credit/entities/repayment_index_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/theme_utils.dart';
import 'package:shine_credit/widgets/coupon_shape_border.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';
import 'package:shine_credit/widgets/load_image.dart';

import '../../../entities/loan_product_model.dart';

class LoanAuthHeader extends StatefulWidget {
  const LoanAuthHeader(
      {super.key, required this.model, required this.callback});

  final LoanProductModel model;

  final GenericTypesCallback<LoanAmountDetails> callback;

  @override
  State<LoanAuthHeader> createState() => _LoanAuthHeaderState();
}

class _LoanAuthHeaderState extends State<LoanAuthHeader> {
  late num _selectDays;
  late LoanAmountDetails _selectProduct;

  final GlobalKey<FutureBuilderWidgetState<dynamic>> calculateOrderFreshenKey =
      GlobalKey(debugLabel: 'calculateOrderFreshenKey');

  @override
  void initState() {
    super.initState();

    if (widget.model.tenure.isNotEmpty) {
      _selectDays = widget.model.tenure.first;
    }

    if (widget.model.amountDetails.isNotEmpty) {
      _selectProduct = widget.model.amountDetails.first;
      widget.callback(_selectProduct);
    }
  }

  void _selectDaysAction() {
    if (widget.model.tenure.isEmpty) {
      return;
    }

    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: context.backgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26))),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return DaysSelectItem(
                      selected: widget.model.tenure[index] == _selectDays,
                      days: widget.model.tenure[index],
                      callback: (days) {
                        setState(() {
                          _selectDays = days;
                          Navigator.pop(context);
                        });
                      });
                },
                separatorBuilder: (context, index) => Gaps.vGap10,
                itemCount: widget.model.tenure.length),
          ));
        });
  }

  void _selectProductAction() {
    if (widget.model.product.isEmpty) {
      return;
    }
    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: context.backgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26))),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ProductSelectItem(
                      selected:
                          widget.model.amountDetails[index] == _selectProduct,
                      model: widget.model.amountDetails[index],
                      callback: (item) =>
                          {updateSelectProduct(item), Navigator.pop(context)});
                },
                separatorBuilder: (context, index) => Gaps.vGap10,
                itemCount: widget.model.amountDetails.length),
          ));
        });
  }

  void updateSelectProduct(LoanAmountDetails model) {
    setState(() {
      widget.callback(model);
      _selectProduct = model;
      calculateOrderFreshenKey.currentState?.retry();
    });
  }

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
            if (widget.model.amountDetails.isNotEmpty)
              ProductSelectItem(
                selected: true,
                model: _selectProduct,
                callback: (_) => _selectProductAction(),
              ),
            if (widget.model.tenure.isNotEmpty)
              DaysSelectItem(
                selected: false,
                days: _selectDays,
                callback: (_) => _selectDaysAction(),
              ),
            Expanded(
              child: FutureBuilderWidget(
                  key: calculateOrderFreshenKey,
                  futureFunc: _calculateOrder,
                  builder: (context, data) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 31, right: 15, bottom: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Amount Received',
                                    style: TextStyle(
                                        color: Colours.text, fontSize: 15)),
                                const Spacer(),
                                Text(
                                    data!.receivedAmount.isEmpty
                                        ? ''
                                        : '₹ ${data.receivedAmount}',
                                    style: const TextStyle(
                                        color: Colours.text_gray,
                                        fontSize: 16)),
                              ],
                            ),
                            Gaps.vGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Repayment Date',
                                    style: TextStyle(
                                        color: Colours.text, fontSize: 15)),
                                const Spacer(),
                                Text(data.repaymentDate,
                                    style: const TextStyle(
                                        color: Colours.text_gray,
                                        fontSize: 16)),
                              ],
                            ),
                            Gaps.vGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Amount Received',
                                    style: TextStyle(
                                        color: Colours.text, fontSize: 15)),
                                const Spacer(),
                                Text(data.loanRate,
                                    style: const TextStyle(
                                        color: Colours.text_gray,
                                        fontSize: 16)),
                              ],
                            )
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<RepaymentIndexModel?> _calculateOrder() async {
    try {
      final result =
          await DioUtils.instance.client.calculateOrder(tenantId: '1', body: {
        'loanAmount': _selectProduct.amount,
        'productIds': _selectProduct.productIds,
      });
      return result.data;
    } catch (e) {
      return null;
    }
  }
}

class DaysSelectItem extends StatelessWidget {
  const DaysSelectItem({
    super.key,
    required this.days,
    required this.callback,
    required this.selected,
  });

  final GenericTypesCallback<num> callback;

  final num days;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: selected ? Colours.app_main_light_bg : Colors.white,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => callback(days),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tenure',
                      style: TextStyle(
                          fontSize: Dimens.font_sp15,
                          color: Colours.text_gray)),
                  const Spacer(),
                  Text('$days Days',
                      style: const TextStyle(
                          color: Colours.text,
                          fontSize: Dimens.font_sp15,
                          fontWeight: FontWeight.bold)),
                  Gaps.hGap15,
                  const LoadAssetImage('home/arrow_forward_right',
                      fit: BoxFit.fill, width: 20, height: 20),
                ],
              )),
        ),
      ),
    );
  }
}

class ProductSelectItem extends StatelessWidget {
  const ProductSelectItem({
    super.key,
    required this.selected,
    required this.model,
    required this.callback,
  });

  final LoanAmountDetails model;

  final bool selected;

  final GenericTypesCallback<LoanAmountDetails> callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: selected ? Colours.app_main_light_bg : Colors.white,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          onTap: () => callback(model),
          splashColor: Colours.button_disabled,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colours.app_main,
                  ),
                  width: 44,
                  height: 44,
                  child: const LoadAssetImage(
                    'home/loan_wallet_icon',
                    width: 36,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${model.amount}',
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              Gaps.hGap15,
              const LoadAssetImage('home/arrow_forward_right',
                  fit: BoxFit.fill, width: 20, height: 20),
              Gaps.hGap15,
            ],
          ),
        ),
      ),
    );
  }
}
