import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/selected_item.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  final _actionList = [
    {'title': 'Authentication Page', 'icon': 'account/loan'},
    {'title': 'About Us', 'icon': 'account/card'},
    {'title': 'My Settings', 'icon': 'account/contact'},
    {'title': 'Contact Us', 'icon': 'account/address'},
  ];

  List<Widget> buildActionList() {
    final list = <Widget>[];
    for (var index = 0; index < _actionList.length; index++) {
      list.add(SelectedItem(
          onTap: () {},
          leading: LoadAssetImage(_actionList[index]['icon']!,
              width: 30, height: 30),
          title: _actionList[index]['title']!));

      if (index != _actionList.length - 1) {
        list.add(const Divider(height: 0.4, indent: 15, endIndent: 15));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
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
                  aspectRatio: 18 / 11.2,
                  child: LoadAssetImage('login/login_bg',
                      width: double.infinity,
                      fit: BoxFit.fill,
                      format: ImageFormat.webp),
                ),
              ),
              Positioned(
                top: 20,
                child: Column(
                  children: [
                    const CircleAvatar(
                        radius: 37.5,
                        backgroundImage: AssetImage('assets/images/logo.webp')),
                    Gaps.vGap16,
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerRight,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text('13345678976',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                        Positioned(
                          right: -10,
                          child: IconButton(
                              onPressed: () {
                                log.d('edit');
                              },
                              icon: const LoadAssetImage('home/account_edit',
                                  width: 12, height: 12)),
                        ),
                      ],
                    ),
                    Gaps.vGap10,
                    const Text('13345678976',
                        style: TextStyle(
                            fontSize: Dimens.font_sp12, color: Colors.white)),
                    Gaps.vGap15,
                  ],
                ),
              ),
              MyCard(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: SelectedItem(
                    onTap: () {},
                    leading: const Icon(Icons.credit_card,
                        color: Colours.app_main, size: 30),
                    title: 'Loan Records'),
              )
            ],
          ),
          Gaps.vGap10,
          MyCard(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: buildActionList()))
        ])));
  }
}
