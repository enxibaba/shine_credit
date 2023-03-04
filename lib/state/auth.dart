import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shine_credit/entities/login_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:sp_util/sp_util.dart';

import '../entities/user.dart';

part 'auth.g.dart';

/// This notifier holds and handles the authentication state of the application
@riverpod
class AuthNotifier extends _$AuthNotifier {
  static const _sharedUserfsKey = 'user';

  @override
  Future<User> build() async {
    _persistenceRefreshLogic();

    return _loginRecoveryAttempt();
  }

  /// Tries to perform a login with the saved token on the persistant storage.
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<User> _loginRecoveryAttempt() async {
    try {
      final savedToken = SpUtil.getString(Constant.accessToken);
      if (savedToken == null) {
        throw const UnauthorizedException(
          "Couldn't find the authentication token",
        );
      }

      return await _loginWithToken();
    } catch (_, __) {
      await SpUtil.remove(Constant.accessToken);
      return const User.signedOut();
    }
  }

  /// Mock of a request performed on logout (might be common, or not, whatevs).
  Future<void> logout() async {
    await Future.delayed(networkRoundTripTime);
    state = const AsyncValue<User>.data(User.signedOut());
  }

  /// Mock of a successful login attempt, which results come from the network.
  Future<void> login(String phone, String password) async {
    state = await AsyncValue.guard<User>(() async {
      final response = await DioUtils.instance.client.logWithPassword(info: {
        'mobile': phone,
        'password': password,
        'adjustId': '1',
        'androidId': ''
      });
      final LoginModel? user = response.data;

      if (user != null &&
          user.accessToken != null &&
          user.accessToken!.isNotEmpty) {
        SpUtil.putString(Constant.accessToken, user.accessToken!);
        SpUtil.putObject(_sharedUserfsKey, user);
        return User.signedIn(
            userId: user.userId!,
            refreshToken: user.refreshToken!,
            token: user.accessToken!,
            expiresTime: user.expiresTime!);
      } else {
        return const User.signedOut();
      }
    });
  }

  Future<User> _loginWithToken() async {
    final login = SpUtil.getObj(_sharedUserfsKey,
        (v) => LoginModel.fromJson(v as Map<String, dynamic>));
    if (login == null) {
      throw const UnauthorizedException(
        "Couldn't find the authentication token",
      );
    } else {
      return User.signedIn(
          userId: login.userId!,
          refreshToken: login.refreshToken!,
          token: login.accessToken!,
          expiresTime: login.expiresTime!);
    }
  }

  /// Internal method used to listen authentication state changes.
  /// When the auth object is in a loading state, nothing happens.
  /// When the auth object is in a error state, we choose to remove the token
  /// Otherwise, we expect the current auth value to be reflected in our persitence API
  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) {
      if (next.isLoading) {
        return;
      }
      if (next.hasError) {
        SpUtil.remove(Constant.accessToken);
        return;
      }

      final val = next.requireValue;

      val.map<void>(
        signedIn: (signedIn) {
          SpUtil.putString(Constant.accessToken, signedIn.token);
        },
        signedOut: (signedOut) {
          SpUtil.remove(Constant.accessToken);
        },
      );
    });
  }
}

/// Simple mock of a 401 exception
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}

/// Mock of the duration of a network request
const networkRoundTripTime = Duration(milliseconds: 750);
