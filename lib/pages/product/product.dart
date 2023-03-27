import 'package:flutter/material.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_refresh_list.dart';
import 'package:shine_credit/widgets/state_layout.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with AutomaticKeepAliveClientMixin<ProductPage> {
  int _page = 1;
  final int _maxPage = 3;
  final StateType _stateType = StateType.loading;

  final List<dynamic> _list = [];

  Future<dynamic> _onRefresh() async {
    log.d('_onRefresh');
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'xxxxxxxxxxx'));
        _page++;
      });
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
          centerTitle: 'Product',
          backgroundColor: Colours.app_main,
        ),
        body: RefreshListView(
            stateType: _stateType,
            hasMore: _page < _maxPage,
            itemCount: _list.length,
            onRefresh: _onRefresh,
            itemBuilder: (_, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10.0),
                      child: const AspectRatio(
                          aspectRatio: 330 / 132,
                          child: Placeholder(
                            color: Colors.grey,
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15),
                      child: Text(
                        'Product List',
                        style: TextStyle(
                            fontSize: Dimens.font_sp18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    ProductItem(callback: (p0) => log.d(p0))
                  ],
                );
              }
              return ProductItem(callback: (p0) => log.d(p0));
            }));
  }

  @override
  bool get wantKeepAlive => true;
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.callback,
  });

  final GenericTypesCallback<String> callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 10.0, bottom: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colours.app_main, width: 0.4),
          color: Colours.app_main_bg,
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'PointKredit',
                style: TextStyle(
                    fontSize: Dimens.font_sp18,
                    fontWeight: FontWeight.bold,
                    color: Colours.text),
              ),
              const Spacer(),
              MyButton(
                  onPressed: () => callback('xxxx'),
                  text: 'Request',
                  radius: 4,
                  fontSize: Dimens.font_sp15,
                  minWidth: 80,
                  minHeight: 30),
            ],
          ),
          Gaps.vGap15,
          const Text(
            'Lonan Amount: 50000',
            style: TextStyle(fontSize: Dimens.font_sp18, color: Colours.text),
          ),
          Gaps.vGap10,
          const Text(
            'high amount no mortgage 1 min',
            style: TextStyle(fontSize: Dimens.font_sp15, color: Colours.text),
          )
        ],
      ),
    );
  }
}
