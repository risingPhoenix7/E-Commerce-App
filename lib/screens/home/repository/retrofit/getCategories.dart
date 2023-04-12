import 'package:definitely_not_amazon/screens/home/repository/model/category.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';

part 'getCategories.g.dart';

@RestApi(baseUrl: Urls.kBaseUrl)
abstract class CategoriesRestClient {
  factory CategoriesRestClient(Dio dio, {String baseUrl}) =
      _CategoriesRestClient;

  @GET(Urls.kGetCategoriesPath)
  Future<List<Category>> getAllCategories();

  @GET(Urls.kGetItemsPath)
  Future<List<MiniItemDetails>> getItemsForCategory(
      @Query("category") String categoryName);

  @GET(Urls.kGetItemsPath)
  Future<List<MiniItemDetails>> getItemsForSearch(
      @Query("search") String searchName);

  @GET(Urls.kGetItemsPath)
  Future<List<MiniItemDetails>> getTrendingItems(
      @Query("trending") int trending);

  @GET(Urls.kgetFullItemDetailsPath)
  Future<ItemDetails> getItemFullDetails(@Query("id") String item_id);
}
