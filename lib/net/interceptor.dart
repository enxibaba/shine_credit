// ignore_for_file: strict_raw_type

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tuple/tuple.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String accessToken = SpUtil.getString(Constant.accessToken).nullSafe;
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Accept-Charset'] = 'utf8';
    if (options.headers['Content-Type'] == null) {
      options.headers['Content-Type'] = 'application/json';
    }
    options.headers['channelCode'] = 'AB';
    options.headers['gpsAdId'] = '';
    super.onRequest(options, handler);
  }
}

class TokenInterceptor extends QueuedInterceptor {
  Future<Tuple2<String?, int?>?> getToken() async {
    final Map<String, String> params = <String, String>{};
    params['refreshToken'] = SpUtil.getString(Constant.refreshToken).nullSafe;

    final client = HttpClient();
    try {
      final uri = Uri.http('testapi.shineloa.com', HttpApi.refreshToken);
      HttpClientRequest request = await client.postUrl(uri);
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Accept', 'application/json');
      request.headers.set('Accept-Charset', 'utf8');
      request.headers.set('channelCode', 'AB');
      request.headers.set('gpsAdId', '');
      final String accessToken =
          SpUtil.getString(Constant.accessToken).nullSafe;
      if (accessToken.isNotEmpty) {
        request.headers.set('Authorization', 'Bearer $accessToken');
      }
      request.add(utf8.encode(json.encode(params)));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        print(stringData);
        final refreshTokenInfo =
            json.decode(stringData.toString()) as Map<String, dynamic>;
        return Tuple2(refreshTokenInfo['accessToken'] as String,
            refreshTokenInfo['expiresTime'] as int);
      }
    } finally {
      client.close();
      showTokenExpireAlert();
    }

    return null;
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String accessToken = SpUtil.getString(Constant.accessToken).nullSafe;
    if (accessToken.isEmpty) {
      super.onRequest(options, handler);
    } else {
      final int expiresTime = SpUtil.getInt(Constant.accessTokenExpire)!;

      if (expiresTime > DateTime.now().millisecondsSinceEpoch) {
        super.onRequest(options, handler);
      } else {
        log.i('-----------自动刷新Token------------');
        final Tuple2<String?, int?>? accessTokenInfo =
            await getToken(); // 获取新的accessToken
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
      if (response.data['code'] == 401) {
        ToastUtils.cancelToast();
        showTokenExpireAlert();
      } else {
        ToastUtils.show(response.data['msg'] as String);
      }
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    //获取请求的extra参数，根据参数判断是否需要toast异常信息
    final bool showError = err.requestOptions.extra['showErrorMsg'] as bool;
    if (showError) {
      ToastUtils.show('net work error, ');
    } else {
      ToastUtils.cancelToast();
    }
  }
}
