// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sellerRetro.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SellerRestClient implements SellerRestClient {
  _SellerRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://ujjwalaggarwal.pythonanywhere.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<ItemDetails>> getSellerItems(access) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': access};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<ItemDetails>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/market/get-seller-items/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => ItemDetails.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> updateSellerItem(
    access,
    sellerItemDetails,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': access};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(sellerItemDetails.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/market/update-item/',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
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
