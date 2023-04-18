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
            UserDetailsViewModel.userDetailsModel!.id!.toString())
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
    if(UserDetailsViewModel.userDetailsModel == null || UserDetailsViewModel.userDetailsModel!.id == null){
      throw Exception("Not allowed to access change details. Please login first");
    }
    await client
        .changeCustomerDetails(userDetailsModel,
            UserDetailsViewModel.userDetailsModel!.id!.toString())
        .then((it) {})
        .catchError((Object obj) {
      throw Exception("Error in editing customer details");
    });
  }

  static Future<void> changeSellerDetails(
      Map<String, dynamic> userDetailsModel) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = ChangeDetailsRestClient(dio);

    await client
        .changeSellerDetails(userDetailsModel,
            UserDetailsViewModel.userDetailsModel!.id!.toString())
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
           UserDetailsViewModel.userDetailsModel!.id!.toString())
        .then((it) {
      int id = UserDetailsViewModel.userDetailsModel!.id!;
      UserDetailsViewModel.userDetailsModel = it;
      UserDetailsViewModel.userDetailsModel?.id = id;
    }).catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
  }
}
