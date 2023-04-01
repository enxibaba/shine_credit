import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/product_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_refresh_list.dart';
import 'package:shine_credit/widgets/state_layout.dart';

import '../../state/home.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage>
    with AutomaticKeepAliveClientMixin<ProductPage> {
  int _page = 1;
  num _maxPage = 10;
  final StateType _stateType = StateType.loading;

  List<ProductListItem> _list = [];
  List<String> _bannerList = [];

  Future<void> _onRefresh() async {
    try {
      final data = await DioUtils.instance.client
          .getProductList(tenantId: '1', body: {'pageNo': 1, 'pageSize': 10});
      setState(() {
        _page = 2;
        _maxPage = data.data.product?.total ?? 0;
        _list = data.data.product?.list ?? [];
        _bannerList = data.data.banners ?? [];
      });
    } catch (e) {
      AppUtils.log.e(e);
    }
  }

  Future<void> _onloadMore() async {
    try {
      final data = await DioUtils.instance.client.getProductList(
          tenantId: '1', body: {'pageNo': _page, 'pageSize': 10});
      setState(() {
        _page++;
        _maxPage = data.data.product?.total ?? 0;
        final tmp = data.data.product?.list ?? [];
        _list.addAll(tmp);
        _bannerList = data.data.banners ?? [];
      });
    } catch (e) {
      AppUtils.log.e(e);
    }
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
            hasMore: _list.length < _maxPage,
            itemCount: _list.length,
            onRefresh: _onRefresh,
            loadMore: _onloadMore,
            itemBuilder: (_, index) {
              if (index == 0) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 330 / 132, autoPlay: true),
                          items: _bannerList.map((e) {
                            return LoadImage(e);
                          }).toList(),
                        ),
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
                      ProductItem(
                          item: _list[index],
                          callback: (p0) => {
                                AppUtils.log.d(p0),
                                ref.read(homeProvider.notifier).selectIndex(0)
                              })
                    ]);
              }
              return ProductItem(
                  item: _list[index],
                  callback: (p0) => {
                        AppUtils.log.d(p0),
                        ref.read(homeProvider.notifier).selectIndex(0)
                      });
            }));
  }

  @override
  bool get wantKeepAlive => true;
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.item,
    required this.callback,
  });

  final ProductListItem item;

  final GenericTypesCallback<ProductListItem> callback;

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
              Text(
                item.productName ?? '',
                style: const TextStyle(
                    fontSize: Dimens.font_sp18,
                    fontWeight: FontWeight.bold,
                    color: Colours.text),
              ),
              const Spacer(),
              MyButton(
                  onPressed: () => callback(item),
                  text: 'Request',
                  radius: 4,
                  fontSize: Dimens.font_sp15,
                  minWidth: 80,
                  minHeight: 30),
            ],
          ),
          Gaps.vGap15,
          Text(
            'Lonan Amount:  ₹${item.defaultLoanAmount}',
            style: const TextStyle(
                fontSize: Dimens.font_sp18, color: Colours.text),
          ),
          Gaps.vGap10,
          Text(
            'high amount no mortgage ${item.disbursementTime}',
            style: const TextStyle(
                fontSize: Dimens.font_sp15, color: Colours.text),
          )
        ],
      ),
    );
  }
}
