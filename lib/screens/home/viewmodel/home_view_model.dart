import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/category.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/home/repository/retrofit/getCategories.dart';
import 'package:dio/dio.dart';

class HomeScreenViewModel {
  static Future<List<Category>> getCategories() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    List<Category> categoryList = await client.getAllCategories().then((it) {
      return it;
    }).catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
    return categoryList;
  }

  static Future<List<MiniItemDetails>> getSearchItems(String searchString) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    List<MiniItemDetails> itemDetails = await client.getItemsForSearch(searchString).then((it) {
      return it;
    }).catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
    return itemDetails;
  }

  static Future<List<MiniItemDetails>> getCategoryItems(String categoryString) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    List<MiniItemDetails> itemDetails = await client.getItemsForCategory(categoryString).then((it) {
      return it;
    }).catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
    return itemDetails;
  }

  static Future<List<MiniItemDetails>> getTrendingItems(int trending) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    List<MiniItemDetails> itemList =
    await client.getTrendingItems(trending).then((it) {
      return it;
    }).catchError((Object obj) {
      throw Exception("Error in getting items");
    });
    return itemList;
  }

  static Future<ItemDetails> getItemFullInformation(int item_id) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    ItemDetails itemDetails = await client.getItemFullDetails(item_id.toString()).then((it) {
      return it;
    }).catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting item details");
    });
    return itemDetails;
  }
}
