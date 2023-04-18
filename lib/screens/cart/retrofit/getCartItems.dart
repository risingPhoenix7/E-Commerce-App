import 'package:definitely_not_amazon/screens/cart/model/viewCartItemsModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';

part 'getCartItems.g.dart';

@RestApi(baseUrl: Urls.kBaseUrl)
abstract class CartRestClient {
  factory CartRestClient(Dio dio, {String baseUrl}) = _CartRestClient;

  @GET(Urls.kGetCartPath)
  Future<List<CartItem>> getAllCart(@Header("User-ID") String userID);

  @POST(Urls.kAddToCartPath)
  Future<List<CartItem>> addToCart(
      @Header("User-id") String userID, @Body() PostCartItem postCartItem);

  @POST(Urls.kPlaceOrderPath)
  Future<List<CartItem>> placeOrder(@Header("user-id") String userID);

  @GET(Urls.kgetPastOrdersPath)
  Future<List<OrderItem>> getPastOrders(@Header("user-id") String userID);
}
