import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/screens/seller_screens/model/sellerItemDetails.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../../utils/urls.dart';

part 'sellerRetro.g.dart';

@RestApi(baseUrl: Urls.kBaseUrl)
abstract class SellerRestClient {
  factory SellerRestClient(Dio dio, {String baseUrl}) = _SellerRestClient;

  @GET(Urls.kgetSellerItems)
  Future<List<ItemDetails>> getSellerItems(@Query("userId") String access);

  @PUT(Urls.keditSellerItems)
  Future<void> updateSellerItem(@Query("userId") String access,
      @Body() SellerItemDetails sellerItemDetails);
}
