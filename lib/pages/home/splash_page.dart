import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liveness_plugin/liveness_plugin.dart';
import 'package:shine_credit/pages/home/widgets/permission_sheet.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/theme_utils.dart';
import 'package:shine_credit/widgets/fractionally_aligned_sized_box.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:sp_util/sp_util.dart';

import '../../utils/device_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  // final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  // StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 设置状态栏Icon 颜色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await Device.initDeviceInfo();
      // if (SpUtil.getBool(Constant.keyGuide, defValue: true)!) {
      //   /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
      //   void precacheImages(String image) {
      //     precacheImage(
      //         ImageUtils.getAssetImage(image, format: ImageFormat.webp),
      //         context);
      //   }

      //   _guideList.forEach(precacheImages);
      // }
      _initSplash();
      _initLicenseSDK();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initLicenseSDK() {
    LivenessPlugin.initSDKOfLicense(Market.India);
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    /// 判断是否同意隐私协议
    if (!SpUtil.getBool(Constant.isAgree)!) {
      _showPopup();
    } else {
      Future.delayed(const Duration(milliseconds: 1000)).then((_) {
        // if (SpUtil.getBool(Constant.keyGuide, defValue: true)! ||
        //     Constant.isDriverTest) {
        //   SpUtil.putBool(Constant.keyGuide, false);
        //   _initGuide();
        // } else {
        //   _goLogin();
        // }`
        _goLogin();
      });
    }
  }

  void _goLogin() {
    // const LoginRoute().go(context);
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
            child: LoadAssetImage('logo', format: ImageFormat.webp)));
  }
}


// Swiper(
//                 key: const Key('swiper'),
//                 itemCount: _guideList.length,
//                 loop: false,
//                 itemBuilder: (_, index) {
//                   return LoadAssetImage(
//                     _guideList[index],
//                     key: Key(_guideList[index]),
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                     format: ImageFormat.webp,
//                   );
//                 },
//                 onTap: (index) {
//                   if (index == _guideList.length - 1) {
//                     _goLogin();
//                   }
//                 },
//               )
//

// Future<void> _checkLicense() async {
//     const String license = '''
// 858C4DDC566793C1869E8DD0CC5F81AE
// FB727BC6A8E22E0166EE4F4B423AC807
// 02D3145717AC53FBDEFFCC0F94977E9B
// 97D7B0ACB335A2377261D47903619C22
// 3FEC700D976AD6AC958975060BEE5393
// 886647E8F8123511A70E35A03AE13611
// C4A332A81166B796D090184722B5A144
// 34AF2F6C078C9DF1FABD3DA178F5998A
// C3278C79064D633CE7634F98E49E0765
// DE0907FD21FD5ABA03FDB7D4D435CD6A
// B96AC00F739C697ABE8A672DFFAD0792
// 83040A84CA36A479BEB3A8741E2906EA
//     ''';
//     final String? result = await LivenessPlugin.setLicenseAndCheck(license);
//     print(result);
//     if ('SUCCESS' == result) {
//       // license is valid
//       startLivenessDetection();
//     } else {
//       // license is invalid, expired/format error /appId is invalid
//     }
//   }

//   void startLivenessDetection() {
//     LivenessPlugin.startLivenessDetection(this);
//   }