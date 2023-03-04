import 'package:dio/dio.dart' hide Headers;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shine_credit/entities/login_model.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/service/api_result.dart';

part 'http_service.g.dart';

@RestApi(baseUrl: HttpApi.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(HttpApi.loginByPwd)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<LoginModel?>> logWithPassword({
    @Body() required Map<String, dynamic> info,
  });

  @POST(HttpApi.checkUpdate)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<LoginModel?>> checkUpdate({
    @Part() required String deviceType,
    @Part() required String innerVersionord,
    @Headers() Map<String, dynamic>? headers,
  });
}

@JsonSerializable(genericArgumentFactories: true)
class ValueWrapper<T> {
  const ValueWrapper({required this.value});
  factory ValueWrapper.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ValueWrapperFromJson(json, fromJsonT);

  final T value;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ValueWrapperToJson(this, toJsonT);
}
