import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/loan/loan_auth_page.dart';
import 'package:shine_credit/pages/loan/loan_unauth_page.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/device_utils.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';

import '../../router/router.dart';

class LoanPage extends ConsumerStatefulWidget {
  const LoanPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanPageState();
}

class _LoanPageState extends ConsumerState<LoanPage>
    with RouteAware, AutomaticKeepAliveClientMixin<LoanPage> {
  @override
  bool get wantKeepAlive => true;

  bool shouldUpdateStatus = true;

  final GlobalKey<FutureBuilderWidgetState<dynamic>> authConfigFreshenKey =
      GlobalKey(debugLabel: 'authConfig');

  Future<AuthConfigModel?> requestConfig() async {
    final data = await DioUtils.instance.client.configInit(tenantId: '1');
    return data.data;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Device.isAndroid) {
        final SystemUiOverlayStyle systemUiOverlayStyle =
            SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colours.app_main,
        );
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    if (shouldUpdateStatus) {
      authConfigFreshenKey.currentState?.retry();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLogin = ref.watch(isLoginProvider);
    return isLogin
        ? FutureBuilderWidget<AuthConfigModel?>(
            key: authConfigFreshenKey,
            futureFunc: requestConfig,
            builder: (context, data) {
              if (data != null && data.isAllAuth) {
                shouldUpdateStatus = false;
                return LoanAuthPage(data);
              } else {
                return LoanUnAuthPage(data);
              }
            })
        : LoanUnAuthPage(null);
  }
}
