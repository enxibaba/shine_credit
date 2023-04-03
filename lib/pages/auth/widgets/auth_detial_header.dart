import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/theme_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';

class AuthDetailHeader extends StatefulWidget {
  const AuthDetailHeader({
    super.key,
  });

  @override
  State<AuthDetailHeader> createState() => _AuthDetailHeaderState();
}

class _AuthDetailHeaderState extends State<AuthDetailHeader> {
  void _showPopup() {
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  color: context.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26))),
              child: ListView(
                padding: const EdgeInsets.all(15.0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Gaps.vGap16,
                      Text(
                        'How does the Point Kredit protect your data? Security detection ',
                        style: TextStyle(
                            color: Colours.text,
                            fontSize: Dimens.font_sp15,
                            fontWeight: FontWeight.bold),
                      ),
                      Gaps.vGap24,
                      LoadAssetImage('auth/icon_lock_security',
                          width: 78, height: 46, format: ImageFormat.png),
                      Gaps.vGap18,
                      Text(
                        'Security Detection',
                        style: TextStyle(
                            color: Colours.text,
                            fontSize: Dimens.font_sp15,
                            fontWeight: FontWeight.bold),
                      ),
                      Gaps.vGap8,
                      Text(
                        '${Constant.appName} is very concerned about the protection of customer data. ',
                        style: TextStyle(
                          color: Colours.text_gray,
                          fontSize: Dimens.font_sp12,
                        ),
                      ),
                      Gaps.vGap4,
                      Text(
                        'We use the SSL-256 with encryption to ensure that your data is protected from other irresponsible parties.',
                        style: TextStyle(
                          color: Colours.text_gray,
                          fontSize: Dimens.font_sp12,
                        ),
                      ),
                      Gaps.vGap24,
                      LoadAssetImage('auth/icon_auth_lock',
                          width: 30, height: 30, format: ImageFormat.png),
                      Gaps.vGap18,
                      Text(
                        'Encryption Data',
                        style: TextStyle(
                            color: Colours.text,
                            fontSize: Dimens.font_sp15,
                            fontWeight: FontWeight.bold),
                      ),
                      Gaps.vGap8,
                      Text(
                        'We will encrypt your data during transfer and during storage. None of our people can see the user ID and password when you entered. We have demonstrated reliablity using the vanq encryption criteria.',
                        style: TextStyle(
                          color: Colours.text_gray,
                          fontSize: Dimens.font_sp12,
                        ),
                      ),
                      Gaps.vGap24,
                      LoadAssetImage('auth/icon_auth_person',
                          width: 37, height: 32, format: ImageFormat.png),
                      Gaps.vGap18,
                      Text(
                        'Reliable And Experienced Personnel',
                        style: TextStyle(
                            color: Colours.text,
                            fontSize: Dimens.font_sp15,
                            fontWeight: FontWeight.bold),
                      ),
                      Gaps.vGap8,
                      Text(
                        'Our staff have extensive experience in the financial sector to ensure your data security.',
                        style: TextStyle(
                          color: Colours.text_gray,
                          fontSize: Dimens.font_sp12,
                        ),
                      ),
                      Gaps.vGap32,
                    ],
                  ),
                  const Spacer(),
                  OutlinedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 10))),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'CONFIRM',
                        style: TextStyle(
                            color: Colours.text,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPopup,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colours.app_main_bg,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoadAssetImage(
                  'iso_icon',
                  width: 40,
                  height: 40,
                  format: ImageFormat.png,
                ),
                Gaps.hGap10,
                Expanded(
                  child: Text(
                      'As a TUV certified company.We will protect youn informationin accordance with ISO/IEC 27001:2013.',
                      style: TextStyle(
                          color: Colours.text_regular,
                          fontSize: Dimens.font_sp12)),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 6,
              right: 18,
              child: Row(
                children: const [
                  Text(
                    'More detail',
                    style: TextStyle(
                        color: Colours.app_main, fontSize: Dimens.font_sp14),
                  ),
                  Gaps.hGap5,
                  LoadAssetImage('home/arrow_forward_right',
                      width: 7, height: 12.4)
                ],
              ))
        ],
      ),
    );
  }
}
