import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/entities/uri_info.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/login/widgets/header_bar.dart';
import 'package:shine_credit/pages/login/widgets/my_text_field.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/auth.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/change_notifier_manage.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_scroll_view.dart';
import 'package:sp_util/sp_util.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with ChangeNotifierMixin<LoginPage> {
  //定义一个controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  bool _isAgree = false;
  bool _isPwdLogin = true;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 设置状态栏Icon 颜色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
    _nameController.text = SpUtil.getString(Constant.phone).nullSafe;
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 10) {
      clickable = false;
    }

    if (password.isEmpty || password.length < 4) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _isAgreeChange(bool value) {
    setState(() {
      _isAgree = value;
    });
  }

  void _isLoginChange(bool value) {
    if (_isPwdLogin != value) {
      setState(() {
        _isPwdLogin = value;
        _passwordController.text = '';
      });
    }
  }

  Future<void> _login() async {
    final String name = _nameController.text.trim();
    final String password = _passwordController.text.trim();

    if (!_isAgree) {
      ToastUtils.show('Please agree to the user agreement');
      return;
    }

    ToastUtils.showLoading();

    /// 保存用户号码
    SpUtil.putString(Constant.phone, name);

    if (_isPwdLogin) {
      ref
          .watch(authNotifierProvider.notifier)
          .login(name, password)
          .whenComplete(() => {
                ToastUtils.cancelToast(),
              });
    } else {
      ref
          .watch(authNotifierProvider.notifier)
          .loginWithCode(name, password)
          .whenComplete(() => {
                ToastUtils.cancelToast(),
              });
    }
  }

  Future<bool> _getCode() async {
    final String name = _nameController.text.trim();

    if (name.isEmpty || name.length < 10) {
      ToastUtils.show('Please enter the correct phone number');
      return Future<bool>.value(false);
    }

    try {
      ToastUtils.showLoading();
      final tmp = await DioUtils.instance.client.sendCode(tenantId: '1', body: {
        'mobile': name,
        'scene': 1,
        'type': 1,
      });

      if (tmp.data) {
        ToastUtils.cancelToast();
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } catch (e) {
      ToastUtils.cancelToast();
      return Future<bool>.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: defaultTargetPlatform != TargetPlatform.iOS,
      body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(
              context, <FocusNode>[_nodeText1, _nodeText2]),
          bottomButton: _buildBottomBar,
          children: _buildBody),
    );
  }

  /// 底部操作按钮
  Widget get _buildBottomBar {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _isAgreeChange(!_isAgree),
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, top: 16, bottom: 16),
                    child: _isAgree
                        ? const LoadAssetImage('checked_icon',
                            width: 16, height: 15)
                        : const LoadAssetImage('un_check_circle',
                            width: 16, height: 15)),
              ),
              const Text('Agree'),
              Gaps.hGap4,
              InkWell(
                onTap: () {
                  final info =
                      UriInfo('User services', HttpApi.userAgreementUri);
                  WebViewRoute(info.encodingJsonString()).push(context);
                },
                child: const Text('User services',
                    style: TextStyle(color: Colours.app_main)),
              ),
              Gaps.hGap4,
              const Text('&'),
              Gaps.hGap4,
              InkWell(
                onTap: () {
                  final info =
                      UriInfo('Privacy policy', HttpApi.privacyPolicyUri);
                  WebViewRoute(info.encodingJsonString()).push(context);
                },
                child: const Text('Privacy policy',
                    style: TextStyle(color: Colours.app_main)),
              )
            ],
          ),
          MyDecoratedButton(
              radius: 24,
              text: 'Request',
              onPressed: _clickable ? _login : null)
        ],
      ),
    );
  }

  List<Widget> get _buildBody {
    return <Widget>[
      Container(
        color: Colours.app_main,
        height: MediaQuery.of(context).padding.top,
      ),
      const LoginHeader(),
      Container(color: Colours.app_main, height: 1),
      HeaderBar(callback: (value) => _isLoginChange(value)),
      const Padding(
        padding: EdgeInsets.only(left: 25.0, top: 15.0),
        child: Text(
          'Enter your phone number to proceed',
          style: TextStyle(
              color: Colours.text_regular,
              fontSize: Dimens.font_sp18,
              fontWeight: FontWeight.w500),
        ),
      ),
      Gaps.vGap16,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: MyTextField(
            keyName: 'phone',
            maxLength: 10,
            hintText: 'Please enter mobile number',
            controller: _nameController,
            focusNode: _nodeText1),
      ),
      Gaps.vGap10,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: MyTextField(
              isInputPwd: _isPwdLogin,
              maxLength: _isPwdLogin ? 16 : 6,
              hintText:
                  _isPwdLogin ? 'Please enter password' : 'Please enter otp',
              getVCode: _isPwdLogin ? null : _getCode,
              controller: _passwordController,
              focusNode: _nodeText2),
        ),
      ),
      Gaps.vGap32
    ];
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 18 / 13.0,
      child: Stack(
        children: [
          const LoadAssetImage(
            'login/login_bg',
            width: double.infinity,
            fit: BoxFit.fill,
            format: ImageFormat.webp,
          ),
          Center(
            child: Column(
              children: [
                Gaps.vGap24,
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colours.app_main,
                            offset: Offset(1.0, 0),
                            blurRadius: 1)
                      ],
                      image: DecorationImage(
                          image: ImageUtils.getAssetImage('logo',
                              format: ImageFormat.png)),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                Gaps.vGap10,
                const Text(Constant.appName,
                    style: TextStyle(
                        fontSize: Dimens.font_sp18, color: Colors.white)),
                Gaps.vGap15,
                Text('Get instant Personal Loan upto',
                    style: TextStyle(
                        fontSize: Dimens.font_sp18,
                        color: Colors.white.withOpacity(0.8))),
                Gaps.vGap15,
                Text('₹ 2 Lakhs',
                    style: TextStyle(
                        fontSize: Dimens.font_sp18,
                        color: Colors.white.withOpacity(0.8))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
