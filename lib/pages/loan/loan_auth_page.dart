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
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/round_check_box.dart';
import 'package:shine_credit/widgets/selected_item.dart';

class LoanAuthPage extends ConsumerStatefulWidget {
  const LoanAuthPage(this.authConfigModel, {super.key});

  final AuthConfigModel authConfigModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanAuthPageState();
}

class _LoanAuthPageState extends ConsumerState<LoanAuthPage> {
  bool _isAgree = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 设置状态栏Icon 颜色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });

    requestData();
  }

  Future<LoanProductModel?> requestData() async {
    try {
      final data =
          await DioUtils.instance.client.loanProductList(tenantId: '1');
      return data.data;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_gray_,
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(children: [
                Container(
                  color: Colours.app_main,
                  height: MediaQuery.of(context).padding.top,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: AspectRatio(
                        aspectRatio: 360 / 224,
                        child: LoadAssetImage('home/home_bg',
                            width: double.infinity,
                            fit: BoxFit.fill,
                            format: ImageFormat.png),
                      ),
                    ),
                    LoanAuthHeader(),
                  ],
                ),
                Gaps.vGap15,
                MyCard(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SelectedItem(
                    title: 'orders processing currently',
                    titleStyle:
                        const TextStyle(fontSize: 15, color: Colours.text_gray),
                    onTap: () {},
                  ),
                ),
                Gaps.vGap15,
                MyCard(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SelectedItem(
                    title: 'bulecash',
                    titleStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('₹ 3000',
                            style: TextStyle(
                                color: Colours.app_main,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                        Gaps.hGap24,
                        RoundCheckBox(
                            checkedColor: Colours.app_main.withOpacity(0.1),
                            size: 16,
                            isChecked: _isAgree,
                            onTap: (value) {
                              setState(() {
                                _isAgree = value!;
                              });
                            }),
                        Gaps.hGap4,
                      ],
                    ),
                  ),
                ),
                const Expanded(child: ColoredBox(color: Colours.bg_gray)),
                const LoanTipsBar(),
                Gaps.vGap24,
              ]))
        ]));
  }
}
