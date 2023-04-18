import 'dart:convert';

import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/seller_screens/model/sellerItemDetails.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SellerScreensViewModel {
  static uploadSellerDetails(
      SellerItemDetails itemDetails, List<XFile> images) async {
    final url = Uri.parse(
        "${Urls.kBaseUrl}${Urls.kPostItemDetailsPath}?userId=${UserDetailsViewModel.userDetailsModel?.id ?? 1}");
    final request = http.MultipartRequest('POST', url);
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
    final itemDetailsJson = jsonEncode(itemDetails.toJson());
    request.fields.addAll({
      'itemDetails': itemDetailsJson,
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Item created successfully');
    } else {
      print('Error creating item');
    }
  }

  // static Future<List<MiniItemDetails>> getSellerItems() async {
  //   return [MiniItemDetails()]
  // }
}
