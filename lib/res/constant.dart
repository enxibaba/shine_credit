import 'package:flutter/foundation.dart';

class Constant {
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String isAgree = 'isAgree';
  static const String phone = 'phone';
  static const String initPwdStatus = 'INIT_PWD_STATUS';
  static const String userId = 'userId';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String accessTokenExpire = 'accessTokenExpire';
  static const String isFirstInstall = 'isFirstInstall';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

  static const String appName = 'Lend Ease';

  static const String privacyTitle =
      'We will require the access of below data to determine the credit risk, prevent frauds, and check your creditworthiness for instant approval. Please go through each permission that explains how and why we collect the details. We use secure HTTPS APIs and cryptographic techniques to encrypt and transfer your information for the utmost privacy.';
  static const String contactsTips =
      'Collect, monitor contacts and accounts information to detect references and to auto fill data during sign up or loan application processes.Also,review &amp; upload contact to diagnosis server （our server https://api.lendeasehub.com) to prevent fraudster and defaulter.';
  static const String smsTips =
      "We access the user's financial transactional SMS and upload on our server（our server https://api.lendeasehub.com） only to monitor the income of the user, track and analyze financial expenses and determine the creditworthiness of the customer for instant credit disbursal. We do not access or store your personal SMS.";
  static const String phoneTips =
      'Collect and monitor specific information about your device including your hardware model, operating System and version, unique device identifier, user profile information, wi- fi information, mobile network Information to uniquely identify the devices and ensure that unauthorised devices are not able to act on your behalf helping us to prevent frauds.';
  static const String cameraTips =
      'Allow you to capture images like your face or documents for eKYC or loan application.';
  static const String storageTips =
      'Allow you to upload documents and pictures for loan application.';
  static const String bankTips = '''
Warm tips：
1.After application approved,we will transfer money to this bank card.
2.The bank card cannot be changed after connect with the app.
3.Don’t change your bank card before repayment done.
4.Please use your own bank card otherwise failed review.
''';

  static const String aboutUs =
      'Lend Ease is a personal loan App which provide urgent cash assistance with simple and secure processes.Aceloan is an APP which provide no-collateral online loan service. Our clients can obtain the initial credit amount quickly, if repaid the loan on time the credit scores would increase.';
  static const String mineEmail = 'moxfirst@gmail.com';
}
