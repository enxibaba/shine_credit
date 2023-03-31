import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/entities/loan_product_model.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/loan/widgets/loan_auth_header.dart';
import 'package:shine_credit/pages/loan/widgets/loan_tips_bar.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/round_check_box.dart';
import 'package:shine_credit/widgets/selected_item.dart';
import 'package:sp_util/sp_util.dart';

class LoanAuthPage extends ConsumerStatefulWidget {
  const LoanAuthPage(this.authConfigModel, {super.key});

  final AuthConfigModel authConfigModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanAuthPageState();
}

class _LoanAuthPageState extends ConsumerState<LoanAuthPage> {
  LoanProductModel? loanProductModel;

  late LoanAmountDetails _selectProduct;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 设置状态栏Icon 颜色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      requestData();
    });
  }

  Future<LoanProductModel?> requestData() async {
    final data = await DioUtils.instance.client.loanProductList(tenantId: '1');
    loanProductModel = data.data;
    return data.data;
  }

  void _loanTipsCallBack() {
    if (loanProductModel != null) {
      if (loanProductModel!.loanStatus) {
        applyProduct();
      } else {
        ToastUtils.show(loanProductModel!.failMessage.nullSafe.isEmpty
            ? 'Please wait a moment'
            : loanProductModel!.failMessage!);
      }
    } else {
      ToastUtils.show('Please wait a moment');
    }
  }

  Future<void> applyProduct() async {
    try {
      ToastUtils.showLoading();

      final data =
          await DioUtils.instance.client.applyOrder(tenantId: '1', body: {
        'address': 'unknown',
        'coordinate': 'unknown',
        'appCode': 0,
        'mobile': SpUtil.getString(Constant.phone),
        'productIds': _selectProduct.productIds,
      });

      if (data.data != null) {
        showApplySuccessDialog(data.data);
      }
    } catch (e) {
      log.e(e.toString());
    } finally {
      ToastUtils.cancelToast();
    }
  }

  void showApplySuccessDialog(LoanProduct model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ApplySuccessDialog(
            model: model,
            callback: () => ref.read(homeProvider.notifier).selectIndex(1));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_gray_,
        body: FutureBuilderWidget(
            futureFunc: requestData,
            builder: (context, data) {
              return CustomScrollView(slivers: [
                SliverToBoxAdapter(
                    child: Column(children: [
                  Container(
                    color: Colours.app_main,
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 100),
                        child: AspectRatio(
                          aspectRatio: 360 / 224,
                          child: LoadAssetImage('home/home_bg',
                              width: double.infinity,
                              fit: BoxFit.fill,
                              format: ImageFormat.png),
                        ),
                      ),
                      LoanAuthHeader(
                          model: data!, callback: (p0) => _selectProduct = p0),
                    ],
                  ),
                  Gaps.vGap16,
                  MyCard(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: SelectedItem(
                        title: 'orders processing currently',
                        titleStyle: const TextStyle(
                            fontSize: 15, color: Colours.text_gray),
                        onTap: () =>
                            ref.read(homeProvider.notifier).selectIndex(1)),
                  ),
                  Gaps.vGap8,
                ])),
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: Stack(children: [
                      Column(
                        children: [
                          Gaps.vGap8,
                          ...data.product.map((item) => MyCard(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: SelectedItem(
                                  title: item.productName ?? '',
                                  titleStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  trailing: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('₹ ${item.defaultLoanAmount ?? ''}',
                                          style: const TextStyle(
                                              color: Colours.app_main,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600)),
                                      Gaps.hGap24,
                                      RoundCheckBox(
                                          checkedColor:
                                              Colours.app_main.withOpacity(0.1),
                                          size: 16,
                                          isChecked: item.check,
                                          onTap: (value) {
                                            setState(() {
                                              item.check = value;
                                            });
                                          }),
                                      Gaps.hGap4,
                                    ],
                                  ),
                                ),
                              )),
                          const Spacer(),
                          LoanTipsBar(onTap: _loanTipsCallBack),
                          Gaps.vGap16
                        ],
                      ),
                      if (!data.loanStatus)
                        Container(
                            color: Colors.black.withOpacity(0.3),
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.lock_outline,
                                    color: Colors.white, size: 50),
                                Gaps.vGap16,
                                Text(data.failMessage ?? '',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ],
                            ))
                    ])),
              ]);
            }));
  }
}

class ApplySuccessDialog extends StatelessWidget {
  const ApplySuccessDialog(
      {super.key, required this.model, required this.callback});

  final LoanProduct model;

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyCard(
            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(children: const [
                        LoadAssetImage('apply_success', width: 60, height: 60),
                        Gaps.vGap10,
                        Text('Applied successfully',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500))
                      ])),
                  SizedBox(
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 24,
                              color: Colours.app_main,
                            ),
                            Container(
                              height: 24,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colours.app_main_bg,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8.5),
                            child: Row(
                              children: const [
                                LoadAssetImage('count_down',
                                    width: 30, height: 30),
                                Gaps.hGap12,
                                Expanded(
                                  child: Text(
                                      'Approval is expected to be completed within 2 minutes',
                                      style: TextStyle(
                                        color: Colours.app_main,
                                        fontSize: 13,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(model.productName ?? '',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18)),
                      Text('₹ ${model.defaultLoanAmount ?? ''}',
                          style: const TextStyle(
                              color: Colours.app_main, fontSize: 18)),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 24),
                      child: SizedBox(
                        height: 40,
                        child: MyDecoratedButton(
                          text: 'Check detail',
                          radius: 20,
                          minHeight: 40,
                          onPressed: () => callback(),
                        ),
                      )),
                ])),
        Gaps.vGap18,
        InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const LoadAssetImage('apply_close', width: 30, height: 30))
      ],
    );
  }
}
