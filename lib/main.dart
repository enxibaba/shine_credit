import 'dart:async';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/utils/state_logger.dart';
import 'package:sp_util/sp_util.dart';


Future<void> main() async {
  // 确保初始化完成
  // ignore: prefer_final_locals
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await SpUtil.getInstance();

  configLoading();

  runApp(
    // 为了让widget能够读取到provider，我们需要在整个应用外面套上一个
    // 名为 "ProviderScope"的widget。
    // 我们的这些provider会在这里保存。
    const ProviderScope(
      observers: [
        StateLogger(),
      ],
      child: MyApp(),
    ),
  );

  // /// 异常处理
  // handleError(() => runApp(
  //       // 为了让widget能够读取到provider，我们需要在整个应用外面套上一个
  //       // 名为 "ProviderScope"的widget。
  //       // 我们的这些provider会在这里保存。
  //       const ProviderScope(
  //         observers: [
  //           StateLogger(),
  //         ],
  //         child: MyApp(),
  //       ),
  //     ));
}

void configLoading() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..fontSize = 16.0
    ..textPadding = const EdgeInsets.only(bottom: 30)
    ..textColor = Colors.white;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    FlutterNativeSplash.remove();
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
