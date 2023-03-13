import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/device_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:sp_util/sp_util.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    if (SpUtil.getString(Constant.accessToken).nullSafe.isNotEmpty) {
      checkUpdate();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> checkUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    log.d(packageInfo.toString());
    DioUtils.instance.client
        .checkUpdate(
            deviceType: Device.platformName,
            innerVersionord: packageInfo.buildNumber,
            tenantId: '1',
            appCode: 0)
        .then((value) => log.d(value))
        .catchError((error) => log.d(error));
  }

  @override
  Widget build(BuildContext context) {
    final barItemList = ref.watch(barItemsProvider);
    final pageList = ref.watch(pageListProvider);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: Dimens.font_sp10,
          unselectedFontSize: Dimens.font_sp10,
          enableFeedback: true,
          items: barItemList,
          currentIndex: ref.watch(homeProvider),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // 禁止滑动
          controller: _pageController,
          onPageChanged: (int index) =>
              ref.watch(homeProvider.notifier).selectIndex(index),
          children: pageList,
        ));
  }
}
