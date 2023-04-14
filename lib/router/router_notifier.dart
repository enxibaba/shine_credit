import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shine_credit/state/home.dart';

import '../state/auth.dart';
import 'routes.dart';
part 'router_notifier.g.dart';

/// This notifier is meant to implement the [Listenable] our [GoRouter] needs.
///
/// We aim to trigger redirects whenever's needed.
/// This is done by calling our (only) listener everytime we want to notify stuff.
/// This allows to centralize global redirecting logic in this class.
/// In this simple case, we just listen to auth changes.
///
/// SIDE NOTE.
/// This might look overcomplicated at a first glance;
/// Instead, this method aims to follow some good some good practices:
///   1. It doesn't require us to pipe down any `ref` parameter
///   2. It works as a complete replacement for [ChangeNotifier] (it's a [Listenable] implementation)
///   3. It allows for listening to multiple providers if needed (we do have a [Ref] now!)
@riverpod
class RouterNotifier extends _$RouterNotifier implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = false;

  @override
  Future<void> build() async {
    // One could watch more providers and write logic accordingly
    isAuth = await ref.watch(
      authNotifierProvider.selectAsync(
          (data) => data.map(signedIn: (_) => true, signedOut: (_) => false)),
    );

    ref.watch(isLoginProvider.notifier).state = isAuth;

    ref.listenSelf((_, __) {
      // One could write more conditional logic for when to call redirection
      if (state.isLoading) {
        return;
      }
      routerListener?.call();
    });
  }

  /// Redirects the user when our authentication changes
  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) {
      return null;
    }

    final isWeb = state.location.startsWith(WebViewRoute.name);

    if (isWeb) {
      return null;
    }

    final isSplash = state.location == SplashRoute.path;

    if (isSplash) {
      return null;
    }

    final isLoggingIn = state.location.startsWith(LoginRoute.path);

    if (isLoggingIn) {
      return isAuth ? HomeRoute.path : null;
    }

    return null;

    // return isAuth ? null : LoginRoute.path;
  }

  /// Our application routes. Obtained through code generation
  List<RouteBase> get routes => $appRoutes;

  /// Adds [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method on creation to handle its
  /// internal [ChangeNotifier].
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  /// Removes [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method when disposing,
  /// so that it removes its callback when destroyed.
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}
