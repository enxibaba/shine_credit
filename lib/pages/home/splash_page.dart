import 'package:flutter/material.dart';
import 'package:shine_credit/pages/home/widgets/permission_sheet.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/theme_utils.dart';
import 'package:shine_credit/widgets/fractionally_aligned_sized_box.dart';
import 'package:sp_util/sp_util.dart';

import '../../utils/device_utils.dart';
import '../../widgets/load_image.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Device.initDeviceInfo();
      _initSplash();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initSplash() {
    /// 判断是否同意隐私协议
    if (!SpUtil.getBool(Constant.isAgree)!) {
      _showPopup();
    } else {
      _goLogin();
    }
  }

  void _goLogin() {
    const HomeRoute().go(context);
  }

  void _showPopup() {
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.86,
            decoration: BoxDecoration(
                color: context.backgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26))),
            child: PermissionSheet(action: () {
              SpUtil.putBool(Constant.isAgree, true);
              _goLogin();
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        body: const FractionallyAlignedSizedBox(
            heightFactor: 0.2,
            widthFactor: 0.2,
            leftFactor: 0.4,
            bottomFactor: 0,
            child: LoadAssetImage('launch_log', format: ImageFormat.png)));
  }
}
