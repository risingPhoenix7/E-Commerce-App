// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getCartItems.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CartRestClient implements CartRestClient {
  _CartRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://ujjwalaggarwal.pythonanywhere.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<CartItem>> getAllCart(userID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userID};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<CartItem>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/view-cart/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => CartItem.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> addToCart(
    userID,
    postCartItem,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userID};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postCartItem.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/users/update-cart/',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
  }

  @override
  Future<void> placeOrder(
    userID,
    postOrderDetails,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userID};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postOrderDetails.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/users/place-order/',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
  }

  @override
  Future<List<OrderItem>> getPastOrders(userID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userID};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<OrderItem>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/past-orders/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => OrderItem.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<SingleOrderDetails> getPastOrderDetails(
    userID,
    orderID,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userID,
      r'order_id': orderID,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SingleOrderDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/past-order-detail/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleOrderDetails.fromJson(_result.data!);
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
