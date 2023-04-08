import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:logger/logger.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

// enum AppEvent {
//   Login('login'),
//   Register('register'),
//   SubmitOrder('submitOrder'),
//   Repayment('repayment'),
//   Installment('installment');

//   const AppEvent(this.eventName);

//   final String eventName;
// }

class AppUtils {
  static final log = Logger(
    printer: PrettyPrinter(),
  );

  static final facebookAppEvents = FacebookAppEvents();

  /// facebook first install app
  static Future<void> facebookFirstInstallApp() async {
    if (SpUtil.getBool(Constant.isFirstInstall)!) {
      await facebookAppEvents.logStartTrial(orderId: '123456789');
      SpUtil.putBool(Constant.isFirstInstall, true);
    }
  }

  /// facebook completed registration
  static Future<void> completedRegistration(String userID) async {
    await facebookAppEvents.logCompletedRegistration(
        registrationMethod: userID);
  }

  /// facebook 加入购物车
  /// id: 商品id
  /// type: 商品类型
  /// currency: 货币类型
  /// price: 商品价格
  static Future<void> facebookAddToCart(
      String id, String type, String currency, double price) async {
    await facebookAppEvents.logAddToCart(
        id: id, type: type, currency: currency, price: price);
  }

  // static Future<void> appEvent(
  //     AppEvent event, Map<String, dynamic>? params) async {
  //   facebookAppEvents.logEvent(name: event.eventName, parameters: params);
  // }

  // static Future<void> facebookLoginAnalyticsEvent(
  //     String userId, String phone) async {
  //   await facebookAppEvents.logEvent(
  //     name: 'Login',
  //     parameters: <String, dynamic>{
  //       'user_id': userId,
  //       'user_phone_no': phone,
  //     },
  //   );
  //   log.d('Successfully Sent loginEvent');
  // }

  static Future<void> launchAppStore(String url) async {
    final Uri uri =
        Uri.parse('https://play.google.com/store/apps/details?id=$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ToastUtils.show('open app store fail');
    }
  }
}
