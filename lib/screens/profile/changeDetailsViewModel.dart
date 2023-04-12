import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:dio/dio.dart';

import 'retrofit/changeDetails.dart';

class ChangeDetailsViewModel {
  static Future<void> changeUserDetails(
      Map<String, dynamic> userDetailsModel) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = ChangeDetailsRestClient(dio);

    await client
        .changeUserDetails(userDetailsModel,
            "Bearer ${UserDetailsViewModel.userDetailsModel!.access}")
        .then((it) {})
        .catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
  }

  static Future<void> changeCustomerDetails(
      Map<String, dynamic> userDetailsModel) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = ChangeDetailsRestClient(dio);

    await client
        .changeCustomerDetails(userDetailsModel,
            "Bearer ${UserDetailsViewModel.userDetailsModel!.access}")
        .then((it) {})
        .catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
  }

  static Future<void> changeSellerDetails(
      Map<String, dynamic> userDetailsModel) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = ChangeDetailsRestClient(dio);

    await client
        .changeSellerDetails(userDetailsModel,
            "Bearer ${UserDetailsViewModel.userDetailsModel!.access}")
        .then((it) {})
        .catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
  }

  static Future<void> updateProfile() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = ChangeDetailsRestClient(dio);

    await client
        .updateProfile(
            "Bearer ${UserDetailsViewModel.userDetailsModel!.access}")
        .then((it) {
      String? access = UserDetailsViewModel.userDetailsModel!.access;
      UserDetailsViewModel.userDetailsModel = it;
      UserDetailsViewModel.userDetailsModel?.access = access;
    }).catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
  }
}
