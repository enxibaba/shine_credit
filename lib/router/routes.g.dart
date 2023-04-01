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
      $aboutUsRoute,
      $mineSettingRoute,
      $contactUsRoute,
      $changeNickNameRoute,
      $repayMentDetailRoute,
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
        GoRouteData.$route(
          path: 'step-second',
          factory: $LoanAutoStepSecondRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'step-third',
          factory: $LoanAutoStepThirdRouteExtension._fromState,
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

extension $LoanAutoStepSecondRouteExtension on LoanAutoStepSecondRoute {
  static LoanAutoStepSecondRoute _fromState(GoRouterState state) =>
      const LoanAutoStepSecondRoute();

  String get location => GoRouteData.$location(
        '/auth-list/step-second',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $LoanAutoStepThirdRouteExtension on LoanAutoStepThirdRoute {
  static LoanAutoStepThirdRoute _fromState(GoRouterState state) =>
      const LoanAutoStepThirdRoute();

  String get location => GoRouteData.$location(
        '/auth-list/step-third',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $aboutUsRoute => GoRouteData.$route(
      path: '/about-us',
      factory: $AboutUsRouteExtension._fromState,
    );

extension $AboutUsRouteExtension on AboutUsRoute {
  static AboutUsRoute _fromState(GoRouterState state) => const AboutUsRoute();

  String get location => GoRouteData.$location(
        '/about-us',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $mineSettingRoute => GoRouteData.$route(
      path: '/mine-setting',
      factory: $MineSettingRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'modify-pwd',
          factory: $ModifyPwdRouteExtension._fromState,
        ),
      ],
    );

extension $MineSettingRouteExtension on MineSettingRoute {
  static MineSettingRoute _fromState(GoRouterState state) => MineSettingRoute(
        $extra: state.extra as NickModel?,
      );

  String get location => GoRouteData.$location(
        '/mine-setting',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  void push(BuildContext context) => context.push(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);
}

extension $ModifyPwdRouteExtension on ModifyPwdRoute {
  static ModifyPwdRoute _fromState(GoRouterState state) =>
      const ModifyPwdRoute();

  String get location => GoRouteData.$location(
        '/mine-setting/modify-pwd',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $contactUsRoute => GoRouteData.$route(
      path: '/contact-us',
      factory: $ContactUsRouteExtension._fromState,
    );

extension $ContactUsRouteExtension on ContactUsRoute {
  static ContactUsRoute _fromState(GoRouterState state) =>
      const ContactUsRoute();

  String get location => GoRouteData.$location(
        '/contact-us',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $changeNickNameRoute => GoRouteData.$route(
      path: '/change-nick-name/:name',
      factory: $ChangeNickNameRouteExtension._fromState,
    );

extension $ChangeNickNameRouteExtension on ChangeNickNameRoute {
  static ChangeNickNameRoute _fromState(GoRouterState state) =>
      ChangeNickNameRoute(
        state.params['name']!,
      );

  String get location => GoRouteData.$location(
        '/change-nick-name/${Uri.encodeComponent(name)}',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

GoRoute get $repayMentDetailRoute => GoRouteData.$route(
      path: '/repayment-detail/:id',
      factory: $RepayMentDetailRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'rollover-payment',
          factory: $RolloverPayMentDetailRouteExtension._fromState,
        ),
      ],
    );

extension $RepayMentDetailRouteExtension on RepayMentDetailRoute {
  static RepayMentDetailRoute _fromState(GoRouterState state) =>
      RepayMentDetailRoute(
        state.params['id']!,
      );

  String get location => GoRouteData.$location(
        '/repayment-detail/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $RolloverPayMentDetailRouteExtension on RolloverPayMentDetailRoute {
  static RolloverPayMentDetailRoute _fromState(GoRouterState state) =>
      RolloverPayMentDetailRoute(
        state.params['id']!,
      );

  String get location => GoRouteData.$location(
        '/repayment-detail/${Uri.encodeComponent(id)}/rollover-payment',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
