import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/provider/model/user_details_model.dart';
import 'package:definitely_not_amazon/provider/retrofit/getUserDetails.dart';
import 'package:dio/dio.dart';

class UserDetailsViewModel {
  static UserDetailsModel? userDetailsModel;

  static Future<void> getUserDetails(String email, String password) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = UserDetailsRestClient(dio);

    await client
        .getUserDetails(LoginPostRequestModel(email: email, password: password))
        .then((it) {
      UserDetailsViewModel.userDetailsModel = it;
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
}
