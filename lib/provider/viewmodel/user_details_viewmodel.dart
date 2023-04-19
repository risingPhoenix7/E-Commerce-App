import 'dart:convert';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/provider/model/user_details_model.dart';
import 'package:definitely_not_amazon/provider/retrofit/getUserDetails.dart';
import 'package:definitely_not_amazon/screens/cart/viewmodel/cart_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsViewModel {
  static UserDetailsModel? userDetailsModel;

  static Future<void> getUserDetails(String email, String password) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = UserDetailsRestClient(dio);

    await client
        .getUserDetails(LoginPostRequestModel(email: email, password: password))
        .then((it) async {
      UserDetailsViewModel.userDetailsModel = it;
      CartViewModel.cartCount.value = it.cart_count ?? 0;
      await storeUserDetails();
    }).catchError((Object obj) {
      throw Exception("Error in getting user details");
    });
  }

  static Future<void> createUser(
      UserLimitedDetailsModel userLimitedDetailsModel) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = UserDetailsRestClient(dio);

    await client
        .createUser(userLimitedDetailsModel)
        .then((it) {})
        .catchError((Object obj) {
      throw Exception("Error in creating user");
    });
  }

  static Future<void> storeUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userDetailsModel == null) {
      throw Exception("User details not found");
    } else {
      String userJson2 = jsonEncode(userDetailsModel!.toJson());
      await prefs.setString('userDetails', userJson2);
    }
  }

  static Future<void> getUserDetailsFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('userDetails');
    if (userJson == null) {
      throw Exception("User details not found");
    } else {
      print(userJson);
      Map<String, dynamic> userMap = json.decode(userJson);
      userDetailsModel = UserDetailsModel.fromJson(userMap);
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userDetailsModel = null;
  }
}
