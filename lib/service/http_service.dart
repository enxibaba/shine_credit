import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/entities/loan_auth_model.dart';
import 'package:shine_credit/entities/loan_product_model.dart';
import 'package:shine_credit/entities/login_model.dart';
import 'package:shine_credit/entities/no_auth_loan_model.dart';
import 'package:shine_credit/entities/person_auth_model.dart';
import 'package:shine_credit/entities/upload_file_model.dart';
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

  @POST(HttpApi.loginByCode)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<LoginModel?>> logWithSmsCode({
    @Body() required Map<String, dynamic> info,
  });

  @POST(HttpApi.checkUpdate)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<LoginModel?>> checkUpdate({
    @Part() required String deviceType,
    @Part() required String innerVersionord,
    @Header('tenant-id') required String tenantId,
    @Header('appCode') required int appCode,
  });

  @POST(HttpApi.configInit)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<AuthConfigModel>> configInit({
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.loanNoAuthInfo)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<NoAuthLoanModel?>> loanNoAuthInfo({
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.loanProductList)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<LoanProductModel?>> loanProductList({
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.refreshToken)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<dynamic>> refreshToken({
    @Part() required String refreshToken,
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.userAuthStatus)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<LoanAuthModel?>> userAuthStatus({
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.uploadFileAuth)
  @MultiPart()
  @Extra({'showErrorMsg': true})
  Future<ApiResult<UploadFileModel>> uploadFileAuth({
    @Part() required String path,
    @Part() File? file,
  });

  @POST(HttpApi.ocrImageInfo)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<PersonAuthModel?>> ocrImagesInfo({
    @Body() required Map<String, dynamic> body,
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.updateAdJustInfo)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<dynamic>> updateAdJustInfo({
    @Header('tenant-id') required String tenantId,
    @Body(nullToAbsent: true) required Map<String, dynamic> info,
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
