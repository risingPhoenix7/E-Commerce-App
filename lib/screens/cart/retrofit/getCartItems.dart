import 'package:definitely_not_amazon/screens/cart/model/viewCartItemsModel.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';

part 'getCartItems.g.dart';

@RestApi(baseUrl: Urls.kBaseUrl)
abstract class CartRestClient {
  factory CartRestClient(Dio dio, {String baseUrl}) = _CartRestClient;

  @GET(Urls.kGetCartPath)
  Future<List<CartItem>> getAllCart(@Query("userId") String userID);

  @POST(Urls.kAddToCartPath)
  Future<void> addToCart(
      @Query("userId") String userID, @Body() PostCartItem postCartItem);

  @POST(Urls.kPlaceOrderPath)
  Future<List<CartItem>> placeOrder(@Query("userId") String userID);

  @GET(Urls.kgetPastOrdersPath)
  Future<List<OrderItem>> getPastOrders(@Query("userId") String userID);

  @GET(Urls.kgetOrderDetailsPath)
  Future<List<MiniItemDetails>> getPastOrderDetails(
      @Query("userId") String userID, @Query("order_id") String orderID);
}
