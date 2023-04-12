import 'package:definitely_not_amazon/provider/model/user_details_model.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/category.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';

part 'getUserDetails.g.dart';

@RestApi(baseUrl: Urls.kBaseUrl)
abstract class UserDetailsRestClient {
  factory UserDetailsRestClient(Dio dio, {String baseUrl}) =
  _UserDetailsRestClient;

//TODO:MAKE IT A POST REQUEST

  @POST(Urls.kGetUserDetailsPath)
  Future<UserDetailsModel> getUserDetails(@Body() LoginPostRequestModel loginPostRequestModel);

  @POST(Urls.kCreateUsersPath)
  Future<void>createUser(@Body() UserLimitedDetailsModel userDetailsModel);
}
