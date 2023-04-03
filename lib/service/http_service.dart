import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/entities/diction_model.dart';
import 'package:shine_credit/entities/liveness_check_result.dart';
import 'package:shine_credit/entities/liveness_license_info.dart';
import 'package:shine_credit/entities/loan_auth_model.dart';
import 'package:shine_credit/entities/loan_product_model.dart';
import 'package:shine_credit/entities/loan_record_detail.dart';
import 'package:shine_credit/entities/loan_record_model.dart';
import 'package:shine_credit/entities/login_model.dart';
import 'package:shine_credit/entities/nick_model.dart';
import 'package:shine_credit/entities/no_auth_loan_model.dart';
import 'package:shine_credit/entities/person_auth_model.dart';
import 'package:shine_credit/entities/product_model.dart';
import 'package:shine_credit/entities/repay_ment_url.dart';
import 'package:shine_credit/entities/repayment_index_model.dart';
import 'package:shine_credit/entities/rollover_pay_ment_model.dart';
import 'package:shine_credit/entities/upload_file_model.dart';
import 'package:shine_credit/net/http_api.dart';
import 'package:shine_credit/service/api_result.dart';

part 'http_service.g.dart';

@RestApi(baseUrl: HttpApi.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(HttpApi.sendCode)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<bool>> sendCode({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

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
  Future<ApiResult<dynamic>> checkUpdate({
    @Body() required Map<String, dynamic> body,
    @Header('tenant-id') required String tenantId,
    @Header('appCode') required int appCode,
  });

  @POST(HttpApi.configInit)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<AuthConfigModel?>> configInit({
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

  @POST(HttpApi.liveNessLicense)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<LivenessLicenseInfo>> liveNessLicense({
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.liveNessCheckResult)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<LivenessCheckResult>> liveNessCheckResult(
      {@Header('tenant-id') required String tenantId,
      @Body() required Map<String, dynamic> body});

  @POST(HttpApi.requestDictData)
  @Extra({'showErrorMsg': false})
  Future<ApiResult<List<DictionModel>>> requestDictData(
      {@Header('tenant-id') required String tenantId,
      @Body() required Map<String, dynamic> body});

  @POST(HttpApi.uploadEmergencyContacts)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<dynamic>> uploadEmergencyContacts(
      {@Header('tenant-id') required String tenantId,
      @Body() required Map<String, dynamic> body});

  @POST(HttpApi.uploadBankCard)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<dynamic>> uploadBankCard(
      {@Header('tenant-id') required String tenantId,
      @Body() required Map<String, dynamic> body});

  @POST(HttpApi.getLoanRecord)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<List<LoanRecordModel>>> getLoanRecord({
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.getRepayMentDetail)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<LoanRecordDetail?>> getRepayMentDetail({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.updateNickName)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<dynamic>> updateNickName({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.getNickName)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<NickModel?>> getNickName({
    @Header('tenant-id') required String tenantId,
  });

  @POST(HttpApi.getProductList)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<Product>> getProductList({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.settingPwd)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<dynamic>> settingPwd({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.calculateOrder)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<RepaymentIndexModel>> calculateOrder({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.applyOrder)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<ApplyProductModel>> applyOrder({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.rolloverPayMentDetail)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<RolloverPayMentModel?>> rolloverPayMentDetail({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.initiateRepayment)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<RepayMentUrl>> initiateRepayment({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
  });

  @POST(HttpApi.getSystemParameters)
  @Extra({'showErrorMsg': true})
  Future<ApiResult<String>> getSystemParameters({
    @Header('tenant-id') required String tenantId,
    @Body() required Map<String, dynamic> body,
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
