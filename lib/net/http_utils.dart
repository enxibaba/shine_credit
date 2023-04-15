// ignore_for_file: prefer_final_locals

import 'package:dio/dio.dart';
import 'package:shine_credit/entities/login_model.dart';
import 'package:shine_credit/net/error_handle.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/net/interceptor.dart';
import 'package:shine_credit/net/pretty_dio_logger.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/service/api_result.dart';
import 'package:shine_credit/service/http_service.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:sp_util/sp_util.dart';

/// 默认dio配置
Duration _connectTimeout = const Duration(seconds: 30);
Duration _receiveTimeout = const Duration(seconds: 30);
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
    _dio.interceptors.add(QueuedInterceptorsWrapper(
      onResponse: (response, handler) async {
        // ignore: avoid_dynamic_calls
        if (response.data['code'] == ExceptionHandle.unauthorized) {
          // token过期
          if (SpUtil.getString(Constant.accessToken).nullSafe.isNotEmpty) {
            final LoginModel? loginModel = await getToken();

            if (loginModel != null && loginModel.accessToken != null) {
              // 保存token
              SpUtil.putString(
                  Constant.accessToken, loginModel.accessToken ?? '');
              SpUtil.putString(
                  Constant.refreshToken, loginModel.refreshToken ?? '');
              // 重新请求
              // ignore: strict_raw_type
              final Response newResponse =
                  await _dio.request(response.requestOptions.path,
                      data: response.requestOptions.data,
                      queryParameters: response.requestOptions.queryParameters,
                      options: Options(
                        headers: response.requestOptions.headers,
                        method: response.requestOptions.method,
                      ));
              return handler.resolve(newResponse);
            } else {
              // 清空token
              showTokenExpireAlert();
            }
          } else {
            showTokenExpireAlert();
          }
        }
        return handler.next(response);
      },
    ));
    _dio.interceptors.add(ErrorMessageInterceptor());
    if (!Constant.inProduction) {
      _dio.interceptors.add(PrettyDioLogger());
    }

    _client = RestClient(_dio, baseUrl: HttpApi.baseUrl);
  }

  final tokenDio = Dio(BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      baseUrl: HttpApi.baseUrl));

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  static late RestClient _client;

  RestClient get client => _client;

  Future<LoginModel?> getToken() async {
    try {
      final result = await tokenDio.post(HttpApi.refreshToken,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Accept-Charset': 'utf8',
                'channelCode': 'AB',
                'gpsAdId': '',
                'Authorization':
                    'Bearer ${SpUtil.getString(Constant.accessToken).nullSafe}'
              },
              responseType: ResponseType.json,
              receiveTimeout: const Duration(seconds: 15),
              sendTimeout: const Duration(seconds: 15)),
          data: {
            'refreshToken': SpUtil.getString(Constant.refreshToken).nullSafe
          });

      final tmp = ApiResult<dynamic>.fromJson(
          result.data as Map<String, dynamic>, (p0) => p0);

      if (tmp.isSuccess && tmp.data != null) {
        try {
          final loginModel =
              LoginModel.fromJson(tmp.data as Map<String, dynamic>);
          return loginModel;
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        AppUtils.log.e(e.response?.data ?? 'Emptry Error data');
        AppUtils.log.e(e.response?.headers ?? 'Emptry Error headers');
      } else {
        AppUtils.log.e(e.message);
      }
      AppUtils.log.e(e.response?.data ?? 'Emptry Error data');
      return null;
    }
  }
}
