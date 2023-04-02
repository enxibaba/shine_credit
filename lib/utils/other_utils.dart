import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/utils/theme_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/exit_dialog.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

typedef GenericTypesCallback<T> = void Function(T);

class Utils {
  static BuildContext? get ctx => navigatorKey.currentContext;
  // /// 打开链接
  // static Future<void> launchWebURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     Toast.show('打开链接失败！');
  //   }
  // }

  // /// 调起拨号页
  // static Future<void> launchTelURL(String phone) async {
  //   final Uri uri = Uri.parse('tel:$phone');
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     Toast.show('拨号失败！');
  //   }
  // }

  /// open email
  /// [email] email address
  /// [subject] email subject
  /// [body] email body
  static Future<void> launchEmailURL(
      {required String email, String subject = '', String body = ''}) async {
    final Uri uri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: <String, String>{'subject': subject, 'body': body});
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ToastUtils.show('open email failed');
    }
  }

  /// 清除用户信息
  static Future<void> clearUserInfo() async {
    await SpUtil.remove(Constant.userId);
    await SpUtil.remove(Constant.accessToken);
    await SpUtil.remove(Constant.refreshToken);
    await SpUtil.remove(Constant.accessTokenExpire);
  }

  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      actions: List.generate(
          list.length,
          (i) => KeyboardActionsItem(
                focusNode: list[i],
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () => node.unfocus(),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text('Close'),
                      ),
                    );
                  },
                ],
              )),
    );
  }

  // static String? getCurrLocale() {
  //   final String locale = SpUtil.getString(Constant.locale)!;
  //   if (locale == '') {
  //     return window.locale.languageCode;
  //   }
  //   return locale;
  // }

  static String decodeUriParams(String title, String url) {
    Map<String, dynamic> params = {title: title, url: url};
    return params.toString();
  }
}

Future<T?> showElasticDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: pageChild,
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 550),
    transitionBuilder: _buildDialogTransitions,
  );
}

Widget _buildDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: const ElasticOutCurve(0.85),
        reverseCurve: Curves.easeOutBack,
      )),
      child: child,
    ),
  );
}

/// String 空安全处理
extension StringExtension on String? {
  String get nullSafe => this ?? '';
}

extension StringExtensions on String {
  String clearSymbolFormat() {
    if (isEmpty) {
      return '';
    }
    return replaceAll(RegExp(r'[\n()\- ]'), '');
  }
}

/// token过期 退出登录
void showTokenExpireAlert() {
  if (Utils.ctx != null) {
    showElasticDialog<void>(
      context: Utils.ctx!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ExitDialog();
      },
    );
  }
}
