import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shine_credit/entities/login_model.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/net/interceptor.dart';
import 'package:shine_credit/net/pretty_dio_logger.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/service/http_service.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:sp_util/sp_util.dart';

/// 默认dio配置
Duration _connectTimeout = const Duration(seconds: 15);
Duration _receiveTimeout = const Duration(seconds: 15);
Duration _sendTimeout = const Duration(seconds: 30);

class DioUtils {
  factory DioUtils() => _singleton;
  DioUtils._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      baseUrl: HttpApi.baseUrl,
    );

    _dio = Dio(options);

    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(ErrorMessageInterceptor());

    if (!Constant.inProduction) {
      _dio.interceptors
          .add(PrettyDioLogger(requestHeader: true, requestBody: true));
    }

    _client = RestClient(_dio, baseUrl: HttpApi.baseUrl);
  }

  Future<LoginModel?> getToken() async {
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
        final jsonDic =
            json.decode(stringData.toString()) as Map<String, dynamic>;
        final model =
            LoginModel.fromJson(jsonDic['data'] as Map<String, dynamic>);
        return model;
      }
    } finally {
      client.close();
      // showTokenExpireAlert();
    }

    return null;
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  static late RestClient _client;

  RestClient get client => _client;
}
