import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastUtils {
  static void show(String msg, {int duration = 2000}) {
    EasyLoading.showToast(msg);
  }

  static void cancelToast() {
    EasyLoading.dismiss();
  }

  static void showLoading({String msg = 'loading...'}) {
    EasyLoading.show(status: msg);
  }
}
