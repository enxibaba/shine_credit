import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:logger/logger.dart';

class AppUtils {
  static final log = Logger(
    printer: PrettyPrinter(),
  );

  static final facebookAppEvents = FacebookAppEvents();

  static Future<void> sendLoginAnalyticsEvent(
      String userId, String phone) async {
    await facebookAppEvents.logEvent(
      name: 'Login',
      parameters: <String, dynamic>{
        'user_id': userId,
        'user_phone_no': phone,
      },
    );
    log.d('Successfully Sent loginEvent');
  }
}
