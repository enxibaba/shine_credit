import 'package:dio/dio.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/net/interceptor.dart';
import 'package:shine_credit/net/pretty_dio_logger.dart';
import 'package:shine_credit/res/constant.dart';
import 'package:shine_credit/service/http_service.dart';

class DioUtils {
  factory DioUtils() => _singleton;

  DioUtils._() {
    _dio = Dio();

    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(ErrorMessageInterceptor());

    if (!Constant.inProduction) {
      _dio.interceptors
          .add(PrettyDioLogger(requestHeader: true, requestBody: true));
    }

    _client = RestClient(_dio, baseUrl: HttpApi.baseUrl);
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  static late RestClient _client;

  RestClient get client => _client;
}
