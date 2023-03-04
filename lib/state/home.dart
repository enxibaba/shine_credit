import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shine_credit/pages/account/account_page.dart';
import 'package:shine_credit/pages/loan/loan_page.dart';
import 'package:shine_credit/pages/repayment/repayment_page.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/strings.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:sp_util/sp_util.dart';

part 'home.g.dart';

@riverpod
class Home extends _$Home {
  @override
  int build() {
    return 0;
  }

  // ignore: use_setters_to_change_properties
  void selectIndex(int value) => state = value;
}

final isLoginProvider = StateProvider<bool>(
    (ref) => SpUtil.getString(Constant.accessToken).nullSafe.isNotEmpty);

final List<String> _appBarTitles = [
  Strings.loan,
  Strings.repayment,
  Strings.product,
  Strings.account
];

final pageListProvider = Provider<List<Widget>>((ref) {
  final isLogin = ref.watch(isLoginProvider);
  if (isLogin) {
    return <Widget>[
      const LoanPage(),
      const RepayMentPage(),
      const Text('Product'),
      const AccountPage(),
    ];
  } else {
    return <Widget>[
      const LoanPage(),
      const RepayMentPage(),
      const AccountPage(),
    ];
  }
});

final barItemsProvider = Provider<List<BottomNavigationBarItem>>((ref) {
  final isLogin = ref.watch(isLoginProvider);

  final tmpTitles = isLogin
      ? _appBarTitles
      : _appBarTitles.where((element) => element != Strings.product).toList();

  final List<List<Widget>> tmp = tmpTitles
      .map((e) => [
            LoadAssetImage(
              '${Paths.home}$e',
              width: 28,
              color: Colours.text_gray,
            ),
            LoadAssetImage(
              '${Paths.home}${e}_SEL',
              width: 28,
              color: Colours.app_main,
            ),
          ])
      .toList();

  return List.generate(tmp.length, (i) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: tmp[i][0],
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: tmp[i][1],
      ),
      label: tmpTitles[i],
    );
  });
});
