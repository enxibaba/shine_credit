import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_card.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String _email = '';

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
    return Scaffold(
      appBar: const MyAppBar(
        backgroundColor: Colours.app_main,
        centerTitle: 'Contact Us',
      ),
      body: Column(
        children: [
          MySelectCard(
            onTap: lauchEmail,
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
                    children: [
                      const Text(
                        'Contact E-mail',
                        style: TextStyle(
                          fontSize: Dimens.font_sp15,
                          color: Colours.text,
                        ),
                      ),
                      Gaps.vGap4,
                      FutureBuilder<String>(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CupertinoActivityIndicator();
                            } else if (snapshot.hasData) {
                              return Text(snapshot.data ?? '',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colours.app_main));
                            } else {
                              return const Text(
                                '',
                              );
                            }
                          },
                          future: getEmail()),
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
