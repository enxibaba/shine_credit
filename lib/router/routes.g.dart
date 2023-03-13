// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $splashRoute,
      $loginRoute,
      $webViewRoute,
      $homeRoute,
      $loanAutoRoute,
    ];

GoRoute get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $webViewRoute => GoRouteData.$route(
      path: '/webview/:params',
      factory: $WebViewRouteExtension._fromState,
    );

extension $WebViewRouteExtension on WebViewRoute {
  static WebViewRoute _fromState(GoRouterState state) => WebViewRoute(
        state.params['params']!,
      );

  String get location => GoRouteData.$location(
        '/webview/${Uri.encodeComponent(params)}',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/home',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $loanAutoRoute => GoRouteData.$route(
      path: '/auth-list',
      factory: $LoanAutoRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'step-first',
          factory: $LoanAutoStepFirstRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'detail',
              factory: $LoanAutoStepFirstDetailRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $LoanAutoRouteExtension on LoanAutoRoute {
  static LoanAutoRoute _fromState(GoRouterState state) => const LoanAutoRoute();

  String get location => GoRouteData.$location(
        '/auth-list',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $LoanAutoStepFirstRouteExtension on LoanAutoStepFirstRoute {
  static LoanAutoStepFirstRoute _fromState(GoRouterState state) =>
      const LoanAutoStepFirstRoute();

  String get location => GoRouteData.$location(
        '/auth-list/step-first',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $LoanAutoStepFirstDetailRouteExtension
    on LoanAutoStepFirstDetailRoute {
  static LoanAutoStepFirstDetailRoute _fromState(GoRouterState state) =>
      LoanAutoStepFirstDetailRoute(
        $extra: state.extra as PersonAuthModel?,
      );

  String get location => GoRouteData.$location(
        '/auth-list/step-first/detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  void push(BuildContext context) => context.push(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);
}
