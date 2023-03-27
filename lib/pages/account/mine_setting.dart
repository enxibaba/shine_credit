import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/auth.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';

class MineSettingPage extends ConsumerStatefulWidget {
  const MineSettingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MineSettingPageState();
}

class _MineSettingPageState extends ConsumerState<MineSettingPage> {
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
                    const CircleAvatar(
                        radius: 37.5,
                        backgroundImage: AssetImage('assets/images/logo.webp')),
                    Gaps.vGap15,
                    const Text(
                      '121321231',
                      style: TextStyle(fontSize: 15, color: Colours.text),
                    ),
                    Gaps.vGap5,
                    const Text(
                      '121321231',
                      style: TextStyle(fontSize: 12, color: Colours.text_gray),
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
                              children: const [
                                Text('Reset the login password',
                                    style: TextStyle(
                                        fontSize: Dimens.font_sp15,
                                        color: Colours.text)),
                                Spacer(),
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
