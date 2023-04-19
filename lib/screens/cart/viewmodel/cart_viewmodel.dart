import 'dart:convert';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/cart/model/viewCartItemsModel.dart';
import 'package:definitely_not_amazon/screens/cart/retrofit/getCartItems.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartViewModel {
  static ValueNotifier<int> removeItemFromCartListener = ValueNotifier(-1);
  static List<CartItem> cartItems = [];
  static ValueNotifier<double> totalPrice = ValueNotifier(0);

  static Future<void> getItemsInCart() async {
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
      print('pkoa');
      print(obj.toString());
      print('ewefpkoa');

      throw Exception("Error in getting cart Items");
    });
    if (cartItems.isNotEmpty) {
      CartViewModel.cartItems = cartItems;
    }
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

//todo : not yet implemented
  static Future<List<MiniItemDetails>> getOrderDetails(int order_id) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CartRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to access orders. Please login first");
    }
    SingleOrderDetails singleOrderDetails = await client
        .getPastOrderDetails(
            UserDetailsViewModel.userDetailsModel!.id.toString(),
            order_id.toString())
        .then((it) {
      for (int i = 0; i < it.order_items.length; i++) {
        it.order_items[i].image = it.order_items[i].image =
            Urls.kImageAppendUrl + it.order_items[i].image.toString();
      }
      return it;
    }).catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting order details");
    });
    List<MiniItemDetails> orderItemDetails = singleOrderDetails.order_items;
    return orderItemDetails;
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

  static Future<void> placeOrder(
      String paymentType, String uid, String? couponCode) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CartRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to add to cart. Please login first");
    }
    await client
        .placeOrder(
            UserDetailsViewModel.userDetailsModel!.id.toString(),
            PostOrderDetails(
                paymentType: paymentType, payment_uid: uid, coupon_code: couponCode))
        .catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting cart Items");
    });
  }

  static Future<double> verifyCouponCode(String code) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Urls.kBaseUrl}/${Urls.kVerifyCouponCodePath}/'));
    request.fields.addAll({'coupon_code': '$code'});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

      // Extract 'detail' field as a double
      double detail = jsonResponse['detail'].toDouble();

      return detail;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
