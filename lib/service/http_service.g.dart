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
    baseUrl ??= 'http://api.shineloa.com/';
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
  Future<ApiResult<LoginModel?>> configInit({headers}) async {
    const _extra = <String, dynamic>{'showErrorMsg': false};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResult<LoginModel>>(Options(
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
    final value = ApiResult<LoginModel?>.fromJson(
      _result.data!,
      (json) => json == null
          ? null
          : LoginModel.fromJson(json as Map<String, dynamic>),
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
    final _data = <String, dynamic>{};
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
