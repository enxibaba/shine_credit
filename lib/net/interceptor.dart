// ignore_for_file: strict_raw_type

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/state/auth.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tuple/tuple.dart';

import '../main.dart';
import '../res/constant.dart';
import '../utils/other_utils.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String accessToken = SpUtil.getString(Constant.accessToken).nullSafe;
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Accept-Charset'] = 'utf8';
    options.headers['Content-Type'] = 'application/json';
    options.headers['channelCode'] = 'AB';
    options.headers['gpsAdId'] = '';
    super.onRequest(options, handler);
  }
}

class TokenInterceptor extends QueuedInterceptor {
  Dio? _tokenDio;

  Future<Tuple2<String?, int?>?> getToken() async {
    final Map<String, String> params = <String, String>{};
    params['refreshToken'] = SpUtil.getString(Constant.refreshToken).nullSafe;
    try {
      _tokenDio ??= Dio();
      _tokenDio!.options = DioUtils.instance.dio.options;
      final Response<dynamic> response =
          await _tokenDio!.post<dynamic>(HttpApi.refreshToken, data: params);
      if (response.statusCode == 200) {
        final refreshTokenInfo =
            json.decode(response.data.toString()) as Map<String, dynamic>;
        return Tuple2(refreshTokenInfo['accessToken'] as String,
            refreshTokenInfo['expiresTime'] as int);
      }
    } catch (e) {
      log.w('刷新Token失败！');
      container.read(authNotifierProvider.notifier).logout();
    }
    return null;
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String accessToken = SpUtil.getString(Constant.accessToken).nullSafe;
    print('onRequest RequestInterceptorHandler: $accessToken');
    if (accessToken.isEmpty) {
      super.onRequest(options, handler);
    } else {
      final int expiresTime = SpUtil.getInt(Constant.accessTokenExpire)!;
      print('Time:');
      print(expiresTime);
      print(DateTime.now().millisecondsSinceEpoch);
      if (expiresTime > DateTime.now().millisecondsSinceEpoch) {
        super.onRequest(options, handler);
      } else {
        log.i('-----------自动刷新Token------------');
        final Tuple2<String?, int?>? accessTokenInfo =
            await getToken(); // 获取新的accessToken
        log.w('-----------NewToken: $accessToken ------------');
        SpUtil.putString(Constant.accessToken, accessToken.nullSafe);
        if (accessTokenInfo != null) {
          SpUtil.putString(Constant.accessToken, accessTokenInfo.item1 ?? '');
          SpUtil.putInt(Constant.accessTokenExpire, accessTokenInfo.item2 ?? 0);
          // 重新请求失败接口
          options.headers['Authorization'] = 'Bearer $accessToken';
          try {
            log.w('----------- 重新请求接口 ------------');
            return handler.next(options);
          } on DioError catch (e) {
            return handler.reject(e);
          }
        }
      }
    }
  }
}

class ErrorMessageInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    //获取请求的extra参数，根据参数判断是否需要toasst异常信息
    final bool showError =
        response.requestOptions.extra['showErrorMsg'] as bool;
    //自定义的业务错误
    if (response.data['code'] != 0 && showError) {
      ToastUtils.show(response.data['msg'] as String);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    //获取请求的extra参数，根据参数判断是否需要toast异常信息
    final bool showError = err.requestOptions.extra['showErrorMsg'] as bool;
    //http状态码!=200-300
    if (showError) {
      ToastUtils.show('网络错误');
    }
  }
}
