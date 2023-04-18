import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/screens/seller_screens/model/sellerItemDetails.dart';
import 'package:definitely_not_amazon/screens/seller_screens/retrofit/sellerRetro.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SellerScreensViewModel {
  static uploadSellerDetails({
    required SellerItemDetails sellerItemDetails,
    required List<XFile> images,
  }) async {
    final url = Uri.parse(
        "${Urls.kBaseUrl}${Urls.kAddItemsPath}?userId=${UserDetailsViewModel.userDetailsModel?.id ?? 1}");
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'name': '${sellerItemDetails.name}',
      'mrp': '${sellerItemDetails.mrp}',
      'price': '${sellerItemDetails.price}',
      'description': '${sellerItemDetails.description}',
      'category_id': '${sellerItemDetails.category_id}',
      'quantity': '${sellerItemDetails.quantity}',
    });
    for (var i = 0; i < images.length; i++) {
      final image = images[i];
      final imageData = await image.readAsBytes();
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          imageData,
          filename: 'image$i.jpg',
        ),
      );
    }

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('wrgkjrgk');
      print(response.reasonPhrase);
    }
  }

  static Future<List<ItemDetails>> getSellerItems() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = SellerRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to access cart. Please login first");
    }
    List<ItemDetails> sellerItems = await client
        .getSellerItems(UserDetailsViewModel.userDetailsModel!.id.toString())
        .then((it) {
      for (int i = 0; i < it.length; i++) {
        for (int j = 0; j < it[i].images!.length; j++) {
          it[i].images![j] = Urls.kBaseUrl + it[i].images![j];
        }
      }
      return it;
    }).catchError((Object obj) {
      print('pkoa');
      print(obj.toString());
      print('ewefpkoa');

      throw Exception("Error in getting cart Items");
    });
    return sellerItems;
  }

  static Future<void> updateSellerItem(
      SellerItemDetails sellerItemDetails) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = SellerRestClient(dio);
    if (UserDetailsViewModel.userDetailsModel == null ||
        UserDetailsViewModel.userDetailsModel!.id == null) {
      throw Exception("Not allowed to access seller items. Please login first");
    }
    await client
        .updateSellerItem(UserDetailsViewModel.userDetailsModel!.id.toString(),
            sellerItemDetails)
        .catchError((Object obj) {
      print(obj.toString());
      throw Exception("Error in getting cart Items");
    });
  }
}
