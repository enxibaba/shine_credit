import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shine_credit/entities/update_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/device_utils.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/double_tap_back_exit_app.dart';
import 'package:shine_credit/widgets/load_image.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (SpUtil.getString(Constant.accessToken)!.isNotEmpty) {
        checkUpdate();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> checkUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    try {
      final data = await DioUtils.instance.client.checkUpdate(body: {
        'deviceType': Device.platformName,
        'innerVersionord': packageInfo.buildNumber,
      }, tenantId: '1', appCode: 0);

      if (data.data != null) {
        final updateInfo = data.data;
        if (updateInfo.update) {
          showUpdateDialog(updateInfo);
        }
      }
    } catch (e) {
      AppUtils.log.e(e);
    }
  }

  void showUpdateDialog(UpdateModel model) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => UpdateDialog(model: model),
    );
  }

  @override
  Widget build(BuildContext context) {
    final barItemList = ref.watch(barItemsProvider);
    final pageList = ref.watch(pageListProvider);

    ref.listen(homeProvider, (previous, next) {
      _pageController.jumpToPage(next);
    });

    return DoubleTapBackExitApp(
      child: Scaffold(
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
          )),
    );
  }
}

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    super.key,
    required this.model,
  });
  final UpdateModel model;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        color: Colours.app_main_bg,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const LoadAssetImage(
                  'launch_log',
                  width: 50,
                  height: 50,
                  format: ImageFormat.png,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Constant.appName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'version：${model.version}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              model.updateMsg ?? '',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!model.forceUpdate)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    AppUtils.launchAppStore(model.updateUrl ?? '');
                  },
                  child: const Text('update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 实现一个App更新弹窗
// 1、展示应用的名称、ICcon、版本号、更新日志
// 2、强制更新时，点击取消按钮，不关闭弹窗
// 3、非强制更新时，点击取消按钮，关闭弹窗
// 4、点击确定按钮，关闭弹窗，跳转到应用商店
// 5、美观的UI