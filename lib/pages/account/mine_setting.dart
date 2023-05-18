import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shine_credit/entities/nick_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/auth.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:sp_util/sp_util.dart';

class MineSettingPage extends ConsumerStatefulWidget {
  const MineSettingPage(this.nickModel, {super.key});

  final NickModel? nickModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MineSettingPageState();
}

class _MineSettingPageState extends ConsumerState<MineSettingPage>
    with RouteAware {
  bool hasSetPwd = SpUtil.getInt(Constant.initPwdStatus)! == 1;

  String _email = '';

  @override
  void initState() {
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
    setState(() {
      hasSetPwd = SpUtil.getInt(Constant.initPwdStatus)! == 1;
    });
  }

  Future<String> getEmail() async {
    try {
      final email = await DioUtils.instance.client.getSystemParameters(
          tenantId: '1', body: {'key': 'com.company.email'});
      _email = email.data;
      return email.data;
    } catch (e) {
      return '';
    }
  }

  Future<void> lauchEmail() async {
    if (_email.isEmpty) {
      return;
    }
    await Utils.launchEmailURL(email: _email);
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = ref.watch(isLoginProvider);

    return Scaffold(
        appBar: const MyAppBar(
            centerTitle: 'My settings', backgroundColor: Colours.app_main),
        backgroundColor: Colours.bg_gray_,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    LoadAssetImage(isLogin ? 'user_default' : 'user_unlogin',
                        width: 75, height: 75, format: ImageFormat.png),
                    Gaps.vGap15,
                    Text(
                      widget.nickModel?.nickname ??
                          SpUtil.getString(Constant.phone)!,
                      style: const TextStyle(fontSize: 15, color: Colours.text),
                    ),
                    Gaps.vGap5,
                    Text(
                      SpUtil.getString(Constant.phone)!,
                      style: const TextStyle(
                          fontSize: 12, color: Colours.text_gray),
                    ),
                    Gaps.vGap24,
                    MyCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Row(
                          children:  [
                            const Text('Version Number',
                                style: TextStyle(
                                    fontSize: Dimens.font_sp15,
                                    color: Colours.text)),
                            const Spacer(),
                            FutureBuilder<PackageInfo>(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CupertinoActivityIndicator();
                                  } else if (snapshot.hasData) {
                                    return  Text('${snapshot.data?.version}',
                                        style:const TextStyle(
                                            fontSize: 15, color: Colours.text_gray));
                                  } else {
                                    return const Text(
                                      '',
                                    );
                                  }
                                },
                                future: PackageInfo.fromPlatform()),
                          ],
                        ),
                      ),
                    ),
                    Gaps.vGap15,
                    MySelectCard(
                      onTap: lauchEmail,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Row(
                          children: [
                            const Text('Service Contact Email',
                                style: TextStyle(
                                    fontSize: Dimens.font_sp15,
                                    color: Colours.text)),
                            Gaps.hGap10,
                            FutureBuilder<String>(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CupertinoActivityIndicator();
                                  } else if (snapshot.hasData) {
                                    return Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(snapshot.data ?? '',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colours.app_main)),
                                      ),
                                    );
                                  } else {
                                    return const Text(
                                      '',
                                    );
                                  }
                                },
                                future: getEmail()),
                          ],
                        ),
                      ),
                    ),
                    Gaps.vGap15,
                    if (isLogin)
                      MySelectCard(
                        onTap: () => const ModifyPwdRoute().push(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Row(
                            children: [
                              Text(
                                  hasSetPwd
                                      ? 'Reset the login password'
                                      : 'Set a login password',
                                  style: const TextStyle(
                                      fontSize: Dimens.font_sp15,
                                      color: Colours.text)),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    const Spacer(),
                    if (isLogin)
                      MyDecoratedButton(
                          onPressed: () async {
                            await ref
                                .watch(authNotifierProvider.notifier)
                                .logout();
                            if (context.mounted) {
                              const LoginRoute().go(context);
                            }
                          },
                          text: 'Log out',
                          radius: 24)
                  ]),
                ))
          ]),
        ));
  }
}
