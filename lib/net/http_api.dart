class HttpApi {
  /// 正式环境BaseUrl
  static const String baseUrlProd = 'https://api.lendeasehub.com/';

  static const String baseUrlPTest = 'http://147.139.33.203:48080/';

  /// 测试环境BaseUrl
  static const String baseUrlTest = 'http://testapi.shineloa.com/';

  static const String baseUrl = baseUrlProd;

  static const String staticUrl = 'https://www.lendeasehub.com/';

  /// 隐私政策
  static const String privacyPolicyUri =
      '${staticUrl}protocol/permissions.html';

  /// 用户协议
  static const String userAgreementUri =
      '${staticUrl}protocol/registrationAgreement.html';

  static const String users = 'users/simplezhli';

  /// 刷新Token
  static const String refreshToken = '/app-api/member/auth/refresh-token';

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

  /// 获取Looan产品列表
  static const String loanProductList = 'app-api/loan/getProductList';

  /// 获取用户认证状态
  static const String userAuthStatus =
      'app-api/certification/getUserCertificationStatus';

  /// 上传用户认证信息
  static const String uploadFileAuth = 'app-api/infra/file/upload';

  /// OCR 用户信息
  static const String ocrImageInfo = 'app-api/kyc/ocr';

  /// update Info
  static const String updateAdJustInfo = 'app-api/kyc/submitAdjustInfo';

  /// get liveNessLicense info
  static const String liveNessLicense = 'app-api/kyc/fetch/liveNessLicense';

  /// get liveNessLicense check result
  static const String liveNessCheckResult = 'app-api/kyc/check/liveNess';

  /// 获取字典接口
  /// type: "contact_type" 获取联系人类型
  /// type: "bank_card_type" 获取银行卡类型
  static const String requestDictData = 'app-api/common/getDictData';

  /// 上传紧急联系人
  static const String uploadEmergencyContacts =
      'app-api/certification/uploadEmergencyContacts';

  /// 认证银行卡信息
  static const String uploadBankCard = 'app-api/certification/uploadBankCard';

  /// 获取用户借款记录
  static const String getLoanRecord = 'app-api/loan/getLoanRecord';

  /// 更新用户头像
  static const String updateAvatar = 'app-api/userCenter/update-avatar';

  /// 查询借款记录详情
  static const String getRepayMentDetail = 'app-api/repay/getRepaymentDetails';

  /// 修改用户昵称
  static const String updateNickName = 'app-api/userCenter/update-nickname';

  /// 获取用户信息
  static const String getNickName = 'app-api/userCenter/get';

  /// 获取产品列表
  static const String getProductList = 'app-api/loan/getProductAppList';

  /// 修改密码
  static const String settingPwd = 'app-api/member/auth/update-password';

  /// calculate order price
  static const String calculateOrder = 'app-api/loan/calculateOrderInf';

  /// apply order
  static const String applyOrder = 'app-api/loan/applyOrder';

  /// repay order
  static const String initiateRepayment = 'app-api/repay/initiateRepayment';

  /// get roll over payMent detail
  static const String rolloverPayMentDetail = 'app-api/repay/getDeferDetails';

  /// get system Parameters
  static const String getSystemParameters =
      'app-api/common/getSystemParameters';

  /// upload report data
  static const String uploadReportData = 'app-api/mobile/collectdata/report';
}
