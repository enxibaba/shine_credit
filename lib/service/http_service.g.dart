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
    baseUrl ??= 'http://147.139.33.203:48080/';
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
  Future<ApiResult<LoginModel?>> checkUpdate({
    required deviceType,
    required innerVersionord,
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
    final _data = FormData();
    _data.fields.add(MapEntry(
      'deviceType',
      deviceType,
    ));
    _data.fields.add(MapEntry(
      'innerVersionord',
      innerVersionord,
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoginModel>>(Options(
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
    final value = ApiResult<LoginModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : LoginModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResult<AuthConfigModel>> configInit({required tenantId}) async {
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
    final value = ApiResult<AuthConfigModel>.fromJson(
      _result.data!,
      (json) => AuthConfigModel.fromJson(json as Map<String, dynamic>),
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
  Future<ApiResult<LoanProductModel?>> loanProductList(
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
    final value = ApiResult<LoanProductModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : LoanProductModel.fromJson(json as Map<String, dynamic>),
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