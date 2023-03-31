// ignore_for_file: strict_raw_type, prefer_final_locals, noop_primitive_operations, avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:sp_util/sp_util.dart';

import 'http_api.dart';

class TokenInterceptor extends Interceptor {
  // Future<LoginModel?> getToken() async {
  //   log.d('start refresh token');
  //   final Map<String, String> params = <String, String>{};
  //   params['refreshToken'] = SpUtil.getString(Constant.refreshToken).nullSafe;
  //   final client = HttpClient();
  //   client.connectionTimeout = const Duration(seconds: 15);
  //   try {
  //     final uri = Uri.http(HttpApi.baseUrl, HttpApi.refreshToken);
  //     HttpClientRequest request = await client.postUrl(uri);
  //     request.headers.set('Content-Type', 'application/json');
  //     request.headers.set('Accept', 'application/json');
  //     request.headers.set('Accept-Charset', 'utf8');
  //     request.headers.set('channelCode', 'AB');
  //     request.headers.set('gpsAdId', '');
  //     final String accessToken =
  //         SpUtil.getString(Constant.accessToken).nullSafe;
  //     if (accessToken.isNotEmpty) {
  //       request.headers.set('Authorization', 'Bearer $accessToken');
  //     }
  //     request.add(utf8.encode(json.encode(params)));
  //     HttpClientResponse response = await request.close();
  //     if (response.statusCode == 200) {
  //       final stringData = await response.transform(utf8.decoder).join();
  //       final jsonDic =
  //           json.decode(stringData.toString()) as Map<String, dynamic>;
  //       final model =
  //           LoginModel.fromJson(jsonDic['data'] as Map<String, dynamic>);
  //       return model;
  //     }
  //   } catch (e) {
  //     log.e('-----------getToken error------------');
  //     showTokenExpireAlert();
  //   } finally {}
  //   return null;
  // }

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
    if (options.path == HttpApi.liveNessCheckResult) {
      options.sendTimeout = const Duration(seconds: 60);
    }

    super.onRequest(options, handler);
  }

  // @override
  // Future<void> onResponse(
  //     Response<dynamic> response, ResponseInterceptorHandler handler) async {
  //   //401代表token过期
  //   if (response.data['code'] == ExceptionHandle.unauthorized &&
  //       SpUtil.getString(Constant.accessToken).nullSafe.isNotEmpty) {
  //     final LoginModel? model = await getToken(); // 获取新的accessToken
  //     String accessToken = model?.accessToken ?? '';
  //     SpUtil.putString(Constant.accessToken, accessToken);
  //     SpUtil.putString(Constant.refreshToken, model?.refreshToken ?? '');
  //     if (accessToken != null) {
  //       // 重新请求失败接口
  //       final RequestOptions request = response.requestOptions;
  //       request.headers['Authorization'] = 'Bearer $accessToken';

  //       final Options options = Options(
  //         headers: request.headers,
  //         method: request.method,
  //         receiveTimeout: const Duration(seconds: 15),
  //         sendTimeout: const Duration(seconds: 30),
  //       );

  //       try {
  //         log.d('-----------重新请求开始------------');
  //         final Response<dynamic> response = await DioUtils.instance.dio
  //             .request(request.path, data: request.data, options: options);
  //         log.d('-----------重新请求成功------------');
  //         log.d(response.data.toString());
  //         return handler.next(response);
  //       } on DioError catch (e) {
  //         return handler.reject(e);
  //       }
  //     } else {
  //       log.e('-----------Token 刷新失败------------');
  //       // 退出登录
  //       showTokenExpireAlert();
  //     }
  //   }
  //   super.onResponse(response, handler);
  // }
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
    if (showError) {
      ToastUtils.show('net work error, ');
    } else {
      ToastUtils.cancelToast();
    }
  }
}
