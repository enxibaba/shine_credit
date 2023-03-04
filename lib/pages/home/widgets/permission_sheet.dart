import 'package:flutter/material.dart';
import 'package:shine_credit/pages/home/widgets/permission_list_title.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/res/styles.dart';

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
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colours.app_main),
              shape: MaterialStateProperty.all(const StadiumBorder())),
          onPressed: _isAgree ? widget.action : null,
          child: const Text('please read the above contents'),
        )
      ]),
    );
  }
}
