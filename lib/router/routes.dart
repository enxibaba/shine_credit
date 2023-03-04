import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shine_credit/entities/uri_info.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/pages/home/home_page.dart';
import 'package:shine_credit/pages/home/splash_page.dart';
import 'package:shine_credit/pages/home/webview_page.dart';
import 'package:shine_credit/pages/login/login_page.dart';
import 'package:shine_credit/pages/login/sms_login_page.dart';

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

@TypedGoRoute<LoginRoute>(path: LoginRoute.path, routes: [
  TypedGoRoute<SMSLoginRoute>(path: SMSLoginRoute.path),
])
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

@TypedGoRoute<HomeRoute>(path: HomeRoute.path, routes: [
  TypedGoRoute<UserRoute>(path: UserRoute.path),
])
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

class SMSLoginRoute extends GoRouteData {
  const SMSLoginRoute();
  static const path = 'sms-login';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SMSLoginPage();
}

class UserRoute extends GoRouteData {
  const UserRoute();
  static const path = 'user';

  @override
  Widget build(BuildContext context, GoRouterState state) => const UserPage();
}
