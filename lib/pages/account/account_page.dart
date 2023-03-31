import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/nick_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/selected_item.dart';
import 'package:sp_util/sp_util.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage>
    with RouteAware, AutomaticKeepAliveClientMixin<AccountPage> {
  @override
  bool get wantKeepAlive => true;

  NickModel? _model;

  final _actionList = [
    {'title': 'Authentication Page', 'icon': 'home/account_auth_icon'},
    {'title': 'About Us', 'icon': 'home/account_about_icon'},
    {'title': 'My Settings', 'icon': 'home/account_setting_icon'},
    {'title': 'Contact Us', 'icon': 'home/account_contact_icon'},
  ];

  Future<void> requestUserInfo() async {
    if (SpUtil.getString(Constant.accessToken)!.isEmpty) {
      return;
    }
    final result = await DioUtils.instance.client.getNickName(tenantId: '');
    if (result.code == 0 && result.data != null) {
      setState(() {
        _model = result.data;

        /// 设置设置密码状态
        SpUtil.putInt(Constant.initPwdStatus, _model?.initPwdStatus ?? 0);
      });
    }
  }

  List<Widget> buildActionList() {
    final list = <Widget>[];
    for (var index = 0; index < _actionList.length; index++) {
      list.add(SelectedItem(
          onTap: () {
            switch (index) {
              case 0:
                const LoanAutoRoute().push(context);
                break;
              case 1:
                const AboutUsRoute().push(context);
                break;
              case 2:
                MineSettingRoute($extra: _model).push(context);
                break;
              case 3:
                const ContactUsRoute().push(context);
                break;
            }
          },
          leading: LoadAssetImage(_actionList[index]['icon']!,
              width: 26, height: 26),
          title: _actionList[index]['title']!));

      if (index != _actionList.length - 1) {
        list.add(const Divider(height: 0.4, indent: 15, endIndent: 15));
      }
    }
    return list;
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
  void initState() {
    requestUserInfo();
    super.initState();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    requestUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLogin = ref.watch(isLoginProvider);
    return Scaffold(
        appBar: const MyAppBar(
          isBack: false,
          centerTitle: 'Account',
          backgroundColor: Colours.app_main,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: AspectRatio(
                  aspectRatio: 36 / 19,
                  child: LoadAssetImage('home/account_bg',
                      width: double.infinity,
                      fit: BoxFit.fill,
                      format: ImageFormat.png),
                ),
              ),
              Positioned(
                top: 20,
                child: Column(
                  children: [
                    LoadAssetImage(isLogin ? 'user_default' : 'user_unlogin',
                        width: 75, height: 75, format: ImageFormat.png),
                    Gaps.vGap16,
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerRight,
                      children: [
                        InkWell(
                          onTap: () => isLogin
                              ? ChangeNickNameRoute(_model?.nickname ??
                                      SpUtil.getString(Constant.phone)!)
                                  .push(context)
                              : const LoginRoute().push(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                isLogin
                                    ? (_model?.nickname ??
                                        SpUtil.getString(Constant.phone)!)
                                    : 'Login Now',
                                style: const TextStyle(
                                    fontSize: Dimens.font_sp15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        ),
                        if (isLogin)
                          Positioned(
                            right: -10,
                            child: IconButton(
                                onPressed: () => ChangeNickNameRoute(
                                        _model?.nickname ??
                                            SpUtil.getString(Constant.phone)!)
                                    .push(context),
                                icon: const LoadAssetImage(
                                    'home/account_modify_icon',
                                    width: 12,
                                    height: 12)),
                          ),
                      ],
                    ),
                    Gaps.vGap10,
                    Text(isLogin ? SpUtil.getString(Constant.phone)! : '',
                        style: const TextStyle(
                            fontSize: Dimens.font_sp12, color: Colors.white)),
                    Gaps.vGap15,
                  ],
                ),
              ),
              if (isLogin)
                MyCard(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SelectedItem(
                      onTap: () =>
                          ref.read(homeProvider.notifier).selectIndex(1),
                      leading: const LoadAssetImage('home/account_loan_icon',
                          width: 26, height: 26),
                      title: 'Loan Records'),
                )
            ],
          ),
          Gaps.vGap10,
          MyCard(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  children: List.generate(
                      _actionList.length,
                      (index) => SelectedItem(
                          onTap: () {
                            switch (index) {
                              case 0:
                                isLogin
                                    ? const LoanAutoRoute().push(context)
                                    : const LoginRoute().go(context);
                                break;
                              case 1:
                                const AboutUsRoute().push(context);
                                break;
                              case 2:
                                isLogin
                                    ? MineSettingRoute($extra: _model)
                                        .push(context)
                                    : const LoginRoute().go(context);
                                break;
                              case 3:
                                const ContactUsRoute().push(context);
                                break;
                            }
                          },
                          showLine: index != _actionList.length - 1,
                          leading: LoadAssetImage(_actionList[index]['icon']!,
                              width: 26, height: 26),
                          title: _actionList[index]['title']!))))
        ])));
  }
}
