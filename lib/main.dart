import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/utils/device_utils.dart';
import 'package:shine_credit/utils/handle_error_utils.dart';
import 'package:sp_util/sp_util.dart';

import 'utils/state_logger.dart';

final log = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  // 确保初始化完成
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (Device.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      /// 透明状态栏
      statusBarColor: Colours.app_main,
      systemNavigationBarColor: Colours.app_main,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  await SpUtil.getInstance();

  /// 异常处理
  handleError(() => runApp(
        // 为了让widget能够读取到provider，我们需要在整个应用外面套上一个
        // 名为 "ProviderScope"的widget。
        // 我们的这些provider会在这里保存。
        const ProviderScope(
          observers: [
            StateLogger(),
          ],
          child: MyApp(),
        ),
      ));
}

// 这里我们使用Rivderpod提供的 "ConsumerWidget" 而不是flutter自带的 "StatelessWidget"。
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      builder: (BuildContext context, Widget? child) {
        child = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
        child = EasyLoading.init()(context, child);
        return child;
      },
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Shine Credit',
      theme: ThemeData(
        primaryColor: Colours.app_main,
      ),
    );
  }
}
