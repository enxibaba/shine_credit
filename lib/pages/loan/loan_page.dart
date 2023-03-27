import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/loan/loan_auth_page.dart';
import 'package:shine_credit/pages/loan/loan_unauth_page.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';

class LoanPage extends ConsumerStatefulWidget {
  const LoanPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanPageState();
}

class _LoanPageState extends ConsumerState<LoanPage>
    with AutomaticKeepAliveClientMixin<LoanPage> {
  @override
  bool get wantKeepAlive => true;

  Future<AuthConfigModel?> requestConfig() async {
    final data = await DioUtils.instance.client.configInit(tenantId: '1');
    return data.data;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLogin = ref.watch(isLoginProvider);
    return isLogin
        ? FutureBuilderWidget<AuthConfigModel?>(
            futureFunc: requestConfig,
            builder: (context, data) {
              if (data != null && data.isAllAuth) {
                return LoanAuthPage(data);
              } else {
                return LoanUnAuthPage(data);
              }
            })
        : LoanUnAuthPage(null);
  }
}
