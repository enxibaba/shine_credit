import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastUtils {
  static void show(String msg, {int duration = 2000}) {
    EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
    EasyLoading.showToast(msg);
  }

  static void cancelToast() {
    EasyLoading.dismiss();
  }

  static void showLoading({String msg = 'Please wait a moment...'}) {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: msg);
  }
}
