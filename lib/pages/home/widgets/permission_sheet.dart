import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/pages/home/widgets/permission_list_title.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/res/styles.dart';
import 'package:shine_credit/utils/app_utils.dart';

class PermissionSheet extends StatelessWidget {
  const PermissionSheet({super.key, this.action});

  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(Dimens.gap_dp16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    Gaps.vGap16,
                    Text(Constant.privacyTitle),
                    Gaps.vGap16,
                    PermissionListTitle(
                      title: 'Contacts',
                      tips: Constant.privacyTitle,
                      icon: 'logo',
                    ),
                    Gaps.vGap16,
                    PermissionListTitle(
                      title: 'Phone',
                      tips: Constant.phoneTips,
                      icon: 'logo',
                    ),
                    Gaps.vGap16,
                    PermissionListTitle(
                      title: 'Camera',
                      tips: Constant.cameraTips,
                      icon: 'logo',
                    ),
                    Gaps.vGap16,
                    PermissionListTitle(
                      title: 'Storage',
                      tips: Constant.storageTips,
                      icon: 'logo',
                    ),
                  ],
                )),
          ),
          BottomToolBar(action: action),
        ],
      ),
    );
  }
}

class BottomToolBar extends StatefulWidget {
  const BottomToolBar({
    super.key,
    this.action,
  });

  final VoidCallback? action;

  @override
  State<BottomToolBar> createState() => _BottomToolBarState();
}

class _BottomToolBarState extends State<BottomToolBar> {
  var _isAgree = false;

  final _promiseList = [
    Permission.contacts,
    Permission.camera,
    Permission.photos,
  ];

  Future<void> requestPermission() async {
    for (final element in _promiseList) {
      final status = await element.request();
      if (status.isGranted) {
        AppUtils.log.d('$element Permission granted');
      } else {
        AppUtils.log.d('$element Permission denied');
      }
    }

    widget.action!();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.gap_dp16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(
          children: [
            Checkbox(
              activeColor: Colours.app_main,
              shape: const CircleBorder(),
              value: _isAgree,
              onChanged: (bool? value) {
                setState(() {
                  _isAgree = value!;
                });
              },
            ),
            const Expanded(
              child: Text(
                'accept Terms Conditions And Privacy Policy and receive messages and emails',
                style: TextStyles.textSize12,
              ),
            ),
          ],
        ),
        Gaps.vGap10,
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colours.app_main),
              minimumSize: MaterialStateProperty.all(const Size(0, 48)),
              shape: MaterialStateProperty.all(const StadiumBorder())),
          onPressed: _isAgree ? requestPermission : null,
          child: const Text('please read the above contents'),
        )
      ]),
    );
  }
}
