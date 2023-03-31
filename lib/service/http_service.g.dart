// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueWrapper<T> _$ValueWrapperFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ValueWrapper<T>(
      value: fromJsonT(json['value']),
    );

Map<String, dynamic> _$ValueWrapperToJson<T>(
  ValueWrapper<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'value': toJsonT(instance.value),
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://147.139.7.97:48080/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResult<LoginModel?>> logWithPassword({required info}) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(info);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoginModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/member/auth/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LoginModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : LoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<LoginModel?>> logWithSmsCode({required info}) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(info);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoginModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/member/auth/sms-login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LoginModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : LoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<dynamic>> checkUpdate({
    required body,
    required tenantId,
    required appCode,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'tenant-id': tenantId,
      r'appCode': appCode,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/version/check',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResult<AuthConfigModel?>> configInit({required tenantId}) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<AuthConfigModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/config/init',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<AuthConfigModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : AuthConfigModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<NoAuthLoanModel?>> loanNoAuthInfo(
      {required tenantId}) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<NoAuthLoanModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/loan/getFrontPageMes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<NoAuthLoanModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : NoAuthLoanModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<LoanProductModel>> loanProductList(
      {required tenantId}) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoanProductModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/loan/getProductList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LoanProductModel>.fromJson(
      _result.data!,
      (json) => LoanProductModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<dynamic>> refreshToken({
    required refreshToken,
    required tenantId,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry(
      'refreshToken',
      refreshToken,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/app-api/member/auth/refresh-token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResult<LoanAuthModel?>> userAuthStatus({required tenantId}) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoanAuthModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/certification/getUserCertificationStatus',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LoanAuthModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : LoanAuthModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<UploadFileModel>> uploadFileAuth({
    required path,
    file,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'path',
      path,
    ));
    if (file != null) {
      _data.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<UploadFileModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'app-api/infra/file/upload',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<UploadFileModel>.fromJson(
      _result.data!,
      (json) => UploadFileModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<PersonAuthModel?>> ocrImagesInfo({
    required body,
    required tenantId,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<PersonAuthModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/kyc/ocr',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<PersonAuthModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : PersonAuthModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<dynamic>> updateAdJustInfo({
    required tenantId,
    required info,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(info);
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/kyc/submitAdjustInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResult<LivenessLicenseInfo>> liveNessLicense(
      {required tenantId}) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LivenessLicenseInfo>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/kyc/fetch/liveNessLicense',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LivenessLicenseInfo>.fromJson(
      _result.data!,
      (json) => LivenessLicenseInfo.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<LivenessCheckResult>> liveNessCheckResult({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LivenessCheckResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/kyc/check/liveNess',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LivenessCheckResult>.fromJson(
      _result.data!,
      (json) => LivenessCheckResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<List<DictionModel>>> requestDictData({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<List<DictionModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/common/getDictData',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<List<DictionModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<DictionModel>(
                  (i) => DictionModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ApiResult<dynamic>> uploadEmergencyContacts({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/certification/uploadEmergencyContacts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResult<dynamic>> uploadBankCard({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/certification/uploadBankCard',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResult<List<LoanRecordModel>>> getLoanRecord(
      {required tenantId}) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<List<LoanRecordModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/loan/getLoanRecord',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<List<LoanRecordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<LoanRecordModel>(
                  (i) => LoanRecordModel.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ApiResult<LoanRecordDetail?>> getRepayMentDetail({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoanRecordDetail>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/repay/getRepaymentDetails',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LoanRecordDetail?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : LoanRecordDetail.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<dynamic>> updateNickName({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/userCenter/update-nickname',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResult<NickModel?>> getNickName({required tenantId}) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<NickModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/userCenter/get',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<NickModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : NickModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<Product>> getProductList({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<Product>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/loan/getProductAppList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<Product>.fromJson(
      _result.data!,
      (json) => Product.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<dynamic>> settingPwd({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/member/auth/update-password',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResult<RepaymentIndexModel>> calculateOrder({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<RepaymentIndexModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/loan/calculateOrderInf',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<RepaymentIndexModel>.fromJson(
      _result.data!,
      (json) => RepaymentIndexModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<LoanProduct>> applyOrder({
    required tenantId,
    required body,
  }) async {
    const _extra = <String, dynamic>{'showErrorMsg': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'tenant-id': tenantId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoanProduct>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'app-api/loan/applyOrder',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResult<LoanProduct>.fromJson(
      _result.data!,
      (json) => LoanProduct.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
