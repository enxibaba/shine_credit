import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shine_credit/entities/person_auth_model.dart';
import 'package:shine_credit/entities/uri_info.dart';
import 'package:shine_credit/pages/account/about_us.dart';
import 'package:shine_credit/pages/account/change_nice_name.dart';
import 'package:shine_credit/pages/account/contact_us.dart';
import 'package:shine_credit/pages/account/mine_setting.dart';
import 'package:shine_credit/pages/account/modify_pwd.dart';
import 'package:shine_credit/pages/auth/auth_list_page.dart';
import 'package:shine_credit/pages/auth/auth_step_first.dart';
import 'package:shine_credit/pages/auth/auth_step_first_detail.dart';
import 'package:shine_credit/pages/auth/auth_step_second.dart';
import 'package:shine_credit/pages/auth/auth_step_third.dart';
import 'package:shine_credit/pages/home/home_page.dart';
import 'package:shine_credit/pages/home/splash_page.dart';
import 'package:shine_credit/pages/home/webview_page.dart';
import 'package:shine_credit/pages/login/login_page.dart';
import 'package:shine_credit/pages/repayment/repayment_detail.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const path = '/splash';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

@TypedGoRoute<LoginRoute>(path: LoginRoute.path, routes: [])
class LoginRoute extends GoRouteData {
  const LoginRoute();
  static const path = '/login';

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    if (state.location.startsWith(LoginRoute.path)) {
      return state.location;
    } else {
      return LoginRoute.path;
    }
  }

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

@TypedGoRoute<WebViewRoute>(path: WebViewRoute.path)
class WebViewRoute extends GoRouteData {
  const WebViewRoute(this.params);
  final String params;
  static const path = '/webview/:params';
  static const name = '/webview';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final String params = state.params['params'] ?? '';
    final UriInfo info = UriInfo.fromJsonString(params);
    return WebViewPage(
      title: info.title,
      url: info.url,
    );
  }
}

@TypedGoRoute<HomeRoute>(path: HomeRoute.path, routes: [])
class HomeRoute extends GoRouteData {
  const HomeRoute();
  static const path = '/home';

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    if (state.location == HomeRoute.path) {
      return null;
    }
    return HomeRoute.path;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

@TypedGoRoute<LoanAutoRoute>(path: LoanAutoRoute.path, routes: [
  TypedGoRoute<LoanAutoStepFirstRoute>(
      path: LoanAutoStepFirstRoute.path,
      routes: [
        TypedGoRoute<LoanAutoStepFirstDetailRoute>(
            path: LoanAutoStepFirstDetailRoute.path),
      ]),
  TypedGoRoute<LoanAutoStepSecondRoute>(path: LoanAutoStepSecondRoute.path),
  TypedGoRoute<LoanAutoStepThirdRoute>(path: LoanAutoStepThirdRoute.path)
])
class LoanAutoRoute extends GoRouteData {
  const LoanAutoRoute();
  static const path = '/auth-list';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AuthListPage();
}

class LoanAutoStepFirstRoute extends GoRouteData {
  const LoanAutoStepFirstRoute();
  static const path = 'step-first';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AuthStepFirst();
}

class LoanAutoStepFirstDetailRoute extends GoRouteData {
  LoanAutoStepFirstDetailRoute({this.$extra});
  static const path = 'detail';

  final PersonAuthModel? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AuthStepFirstDetail(authModel: $extra);
}

class LoanAutoStepSecondRoute extends GoRouteData {
  const LoanAutoStepSecondRoute();

  static const path = 'step-second';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AuthStepSecond();
}

class LoanAutoStepThirdRoute extends GoRouteData {
  const LoanAutoStepThirdRoute();
  static const path = 'step-third';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AuthStepThird();
}

@TypedGoRoute<AboutUsRoute>(path: AboutUsRoute.path)
class AboutUsRoute extends GoRouteData {
  const AboutUsRoute();
  static const path = '/about-us';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutUsPage();
}

@TypedGoRoute<MineSettingRoute>(path: MineSettingRoute.path, routes: [
  TypedGoRoute<ModifyPwdRoute>(path: ModifyPwdRoute.path),
])
class MineSettingRoute extends GoRouteData {
  const MineSettingRoute();
  static const path = '/mine-setting';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MineSettingPage();
}

class ModifyPwdRoute extends GoRouteData {
  const ModifyPwdRoute();
  static const path = 'modify-pwd';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ModifyPwdPage();
}

@TypedGoRoute<ContactUsRoute>(path: ContactUsRoute.path)
class ContactUsRoute extends GoRouteData {
  const ContactUsRoute();
  static const path = '/contact-us';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ContactUsPage();
}

@TypedGoRoute<ChangeNickNameRoute>(path: ChangeNickNameRoute.path)
class ChangeNickNameRoute extends GoRouteData {
  const ChangeNickNameRoute();
  static const path = '/change-nick-name';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangeNickNamePage();
}

@TypedGoRoute<RepayMentDetailRoute>(path: RepayMentDetailRoute.path)
class RepayMentDetailRoute extends GoRouteData {
  const RepayMentDetailRoute(this.id);
  final String id;
  static const path = '/repayment-detail/:id';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RepayMentDetail(id: state.params['id'] ?? '');
}
