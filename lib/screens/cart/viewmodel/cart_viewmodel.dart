import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/cart/model/viewCartItemsModel.dart';
import 'package:definitely_not_amazon/screens/cart/retrofit/getCartItems.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:dio/dio.dart';

class CartViewModel {
  static Future<List<CartItem>> getItemsInCart() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CartRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to access cart. Please login first");
    }
    List<CartItem> cartItems = await client
        .getAllCart(UserDetailsViewModel.userDetailsModel!.id.toString())
        .then((it) {
      for (int i = 0; i < it.length; i++) {
        it[i].image =
            it[i].image = Urls.kImageAppendUrl + it[i].image.toString();
      }
      return it;
    }).catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting cart Items");
    });
    return cartItems;
  }

  static Future<List<OrderItem>> getOrders() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CartRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to access orders. Please login first");
    }
    List<OrderItem> cartItems = await client
        .getPastOrders(UserDetailsViewModel.userDetailsModel!.id.toString())
        .catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting past orders");
    });
    return cartItems;
  }

  static Future<void> addItemToCart(int item_id, int quantity) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CartRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to add to cart. Please login first");
    }
    await client
        .addToCart(UserDetailsViewModel.userDetailsModel!.id.toString(),
            PostCartItem(item_id: item_id, quantity: quantity))
        .catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting cart Items");
    });
  }

  static Future<void> placeOrder() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CartRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to add to cart. Please login first");
    }
    await client
        .placeOrder(UserDetailsViewModel.userDetailsModel!.id.toString())
        .catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting cart Items");
    });
  }
}
