import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/category.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/home/repository/retrofit/getCategories.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:dio/dio.dart';

class HomeScreenViewModel {
  static Future<List<Category>> getCategories() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    List<Category> categoryList = await client.getAllCategories().then((it) {
      for (int i = 0; i < it.length; i++) {
        it[i].image =
            it[i].image = Urls.kImageAppendUrl + it[i].image.toString();
      }
      return it;
    }).catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
    return categoryList;
  }

  static Future<List<MiniItemDetails>> getSearchItems(
      String searchString) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    List<MiniItemDetails> itemDetails =
        await client.getItemsForSearch(searchString).then((it) {
      for (int i = 0; i < it.length; i++) {
        print(it[i].image.toString());
        it[i].image =
            it[i].image = Urls.kImageAppendUrl + it[i].image.toString();
        print(it[i].image.toString());
      }
      return it;
    }).catchError((Object obj) {
      throw Exception("Error in getting categories");
    });
    return itemDetails;
  }

  static Future<List<MiniItemDetails>> getCategoryItems(
      String categoryString) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = CategoriesRestClient(dio);

    List<MiniItemDetails> itemDetails =
        await client.getItemsForCategory(categoryString).then((it) {
      for (int i = 0; i < it.length; i++) {
        print(it[i].image.toString());
        it[i].image =
            it[i].image = Urls.kImageAppendUrl + it[i].image.toString();
        print(it[i].image.toString());
      }
      return it;
    }).catchError((Object obj) {
      print(obj.toString());
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
      for (int i = 0; i < it.length; i++) {
        it[i].image =
            it[i].image = Urls.kImageAppendUrl + it[i].image.toString();
      }
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

    ItemDetails itemDetails =
        await client.getItemFullDetails(item_id.toString()).then((it) {
      if (it.images != null && it.images!.isNotEmpty) {
        for (int i = 0; i < it.images!.length; i++) {
          print(it.images![i].toString());
          it.images![i] = Urls.kImageAppendUrl + it.images![i].toString();
          print(it.images![i].toString());
        }
      }
      print('printing review image stuff');

      if (it.reviews != null && it.reviews!.isNotEmpty) {
        for (int i = 0; i < it.reviews!.length; i++) {
          print(it.reviews![i].image.toString());
          if (it.reviews![i].image == null) {
            it.reviews![i].image =
                " https://ujjwalaggarwal.pythonanywhere.com/backend-media/default_review_image.jpg";
          } else {
            it.reviews![i].image =
                Urls.kImageAppendUrl + it.reviews![i].image.toString();
            print(it.reviews![i].image.toString());
          }
        }
      }

      return it;
    }).catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting item details");
    });
    return itemDetails;
  }
}
