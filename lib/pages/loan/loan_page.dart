import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/loan/loan_auth_page.dart';
import 'package:shine_credit/pages/loan/loan_unauth_page.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/widgets/state_layout.dart';

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
    try {
      final data = await DioUtils.instance.client.configInit(tenantId: '1');
      return data.data;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLogin = ref.watch(isLoginProvider);
    return isLogin
        ? FutureBuilder(
            builder: (BuildContext context,
                AsyncSnapshot<AuthConfigModel?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isAllAuth) {
                  return LoanAuthPage(snapshot.data!);
                } else {
                  return LoanUnAuthPage(snapshot.data);
                }
              } else {
                return StateLayout(
                    type: snapshot.hasError
                        ? StateType.network
                        : StateType.loading);
              }
            },
            future: requestConfig(),
          )
        : LoanUnAuthPage(null);
  }
}
