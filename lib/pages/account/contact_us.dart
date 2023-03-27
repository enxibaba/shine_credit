import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_card.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        backgroundColor: Colours.app_main,
        centerTitle: 'Contact Us',
      ),
      body: Column(
        children: [
          MyCard(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const LoadAssetImage('home/contact_us',
                      width: 30, height: 30),
                  Gaps.hGap15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Contact E-mail',
                        style: TextStyle(
                          fontSize: Dimens.font_sp15,
                          color: Colours.text,
                        ),
                      ),
                      Gaps.vGap4,
                      Text(Constant.mineEmail,
                          style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.app_main)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
