import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/image_utils.dart';
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
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colours.app_main_bg,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 5)
                        ],
                        image: DecorationImage(
                            image: ImageUtils.getAssetImage('logo',
                                format: ImageFormat.png)),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  Gaps.vGap10,
                  const Text(
                    Constant.appName,
                    style: TextStyle(
                        fontSize: Dimens.font_sp18,
                        color: Colours.text,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap24,
                  const Text(Constant.aboutUs,
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
