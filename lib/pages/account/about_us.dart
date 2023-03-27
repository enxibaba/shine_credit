import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_card.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        backgroundColor: Colours.app_main,
        centerTitle: 'About us',
      ),
      body: Column(
        children: [
          MyCard(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: Column(
                children: const [
                  SizedBox(
                      width: 75,
                      height: 75,
                      child: LoadAssetImage('logo',
                          width: 75, height: 75, format: ImageFormat.webp)),
                  Gaps.vGap10,
                  Text(
                    'Shine Credit',
                    style: TextStyle(
                        fontSize: Dimens.font_sp18,
                        color: Colours.text,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap24,
                  Text(Constant.aboutUs,
                      style: TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Colours.text_regular)),
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
