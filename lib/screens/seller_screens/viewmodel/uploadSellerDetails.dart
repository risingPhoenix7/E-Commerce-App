import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/seller_screens/model/sellerItemDetails.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SellerScreensViewModel {
  static uploadSellerDetails({
    required SellerItemDetails sellerItemDetails,
    required List<XFile> images,
  }) async {
    final url = Uri.parse(
        "${Urls.kBaseUrl}${Urls.kPostItemDetailsPath}?userId=${UserDetailsViewModel.userDetailsModel?.id ?? 1}");
    var headers = {'User-ID': '${UserDetailsViewModel.userDetailsModel!.id!}'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://ujjwalaggarwal.pythonanywhere.com/market/create-item/?userId=25'));
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
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

// static Future<List<MiniItemDetails>> getSellerItems() async {
//   return [MiniItemDetails()]
// }
}
