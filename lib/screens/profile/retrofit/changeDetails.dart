import 'package:definitely_not_amazon/provider/model/user_details_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../../utils/urls.dart';

part 'changeDetails.g.dart';

@RestApi(baseUrl: Urls.kBaseUrl)
abstract class ChangeDetailsRestClient {
  factory ChangeDetailsRestClient(Dio dio, {String baseUrl}) =
      _ChangeDetailsRestClient;

  @PUT(Urls.kUpdateUserPath)
  Future<void> changeUserDetails(@Body() Map<String, dynamic> userDetailsModel,
      @Query("userId") String access);

  @PUT(Urls.kUpdateCustomerPath)
  Future<void> changeCustomerDetails(
      @Body() Map<String, dynamic> userDetailsModel,
      @Query("userId") String access);

  @PUT(Urls.kUpdateSellerPath)
  Future<void> changeSellerDetails(
      @Body() Map<String, dynamic> userDetailsModel,
      @Query("userId") String access);

  @GET(Urls.kUpdateProfilePath)
  Future<UserDetailsModel> updateProfile(@Query("userId") String access);
}
