// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RegisterApi implements RegisterApi {
  _RegisterApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://tmba.padc.com.mm';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<EmailResponse> postRegisterWithEmail(name, email, password, phone,
      googleAccessToken, facebookAccessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'google-access-token': googleAccessToken,
      'facebook-access-token': facebookAccessToken
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EmailResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/api/v1/register',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmailResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmailResponse> postLoginWithEmail(email, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EmailResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/api/v1/email-login',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmailResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MovieResponse> getNowShowingMovie(statusKey) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'status': statusKey};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MovieResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/movies?status=current',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MovieResponse.fromJson(_result.data!);
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
