import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/net/global_http_overrides.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/utils/app_utils.dart';
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

  HttpOverrides.global = GlobalHttpOverrides();

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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    AppUtils.facebookAppEvents.setAutoLogAppEventsEnabled(true);
    AppUtils.facebookFirstInstallApp();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      AppUtils.log.d('getInitialAppLink: $appLink');
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      AppUtils.log.d('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {}

  @override
  Widget build(BuildContext context) {
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
      title: 'Lend Ease',
      theme: ThemeData(
        primaryColor: Colours.app_main,
      ),
    );
  }
}
