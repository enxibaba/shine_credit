class HttpApi {
  /// 正式环境BaseUrl
  static const String baseUrlProd = 'http://api.shineloa.com/';

  /// 测试环境BaseUrl
  static const String baseUrlTest = 'http://testapi.shineloa.com/';

  static const String baseUrl = baseUrlProd;

  /// 隐私政策
  static const String privacyPolicyUri =
      '${baseUrl}yudao-admin/protocol/privacyPolicy.html';

  /// 用户协议
  static const String userAgreementUri =
      '${baseUrl}yudao-admin/protocol/registrationAgreement.html';

  static const String users = 'users/simplezhli';

  /// 刷新Token
  static const String refreshToken = 'app-api/member/auth/refresh-token';

  /// 用户名密码登录
  static const String loginByPwd = 'app-api/member/auth/login';

  /// 验证码登录
  static const String loginByCode = 'app-api/member/auth/sms-login';

  /// 修改密码
  static const String changePwd = 'app-api/member/auth/update-password';

  /// 发送验证码
  static const String sendCode = 'app-api/member/auth/send-sms-code';

  /// 上传文件
  static const String uploadFile = 'app-api/member/infra/file/upload';

  /// 检查更新
  static const String checkUpdate = 'app-api/version/check';

  /// 获取风控上传内容
  static const String configInit = 'app-api/config/init';

  /// 获取Looan产品信息
  static const String loanNoAuthInfo = 'app-api/loan/getFrontPageMes';
}
