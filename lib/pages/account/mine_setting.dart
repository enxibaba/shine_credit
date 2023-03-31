import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/nick_model.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/auth.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/image_utils.dart';
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
                          children: const [
                            Text('Version Number',
                                style: TextStyle(
                                    fontSize: Dimens.font_sp15,
                                    color: Colours.text)),
                            Spacer(),
                            Text('1.0.0',
                                style: TextStyle(
                                    fontSize: 15, color: Colours.text_gray))
                          ],
                        ),
                      ),
                    ),
                    Gaps.vGap15,
                    MyCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Row(
                          children: const [
                            Text('Service Contact Email',
                                style: TextStyle(
                                    fontSize: Dimens.font_sp15,
                                    color: Colours.text)),
                            Spacer(),
                            Text(Constant.mineEmail,
                                style: TextStyle(
                                    fontSize: 15, color: Colours.app_main))
                          ],
                        ),
                      ),
                    ),
                    Gaps.vGap15,
                    if (isLogin)
                      InkWell(
                        onTap: () => const ModifyPwdRoute().push(context),
                        child: MyCard(
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
