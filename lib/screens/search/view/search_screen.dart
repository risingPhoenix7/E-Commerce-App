import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/home/viewmodel/home_view_model.dart';
import 'package:definitely_not_amazon/screens/item/item_details.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, required this.searchText, required this.items})
      : super(key: key);
  String? searchText;
  List<MiniItemDetails>? items;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    return CustomScaffold(
        title: "Search",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Showing results for "),
                  Text(
                    widget.searchText!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            widget.items == null || widget.items!.isEmpty
                ? Expanded(child: Center(child: const Text("No results found")))
                : Expanded(
                    child: GridView.builder(
                      itemCount: widget.items!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              deviceType == DeviceScreenType.mobile ? 2 : 4),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemDetailsCard(
                            itemDetails: widget.items![index]);
                      },
                    ),
                  )
          ],
        ));
  }
}

class ItemDetailsCard extends StatelessWidget {
  const ItemDetailsCard({Key? key, required this.itemDetails})
      : super(key: key);
  final MiniItemDetails itemDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ItemDetails itemDetails2 = ItemDetails();
        try {
          itemDetails2 =
              await HomeScreenViewModel.getItemFullInformation(itemDetails.id!);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemDetailsView(
                        itemDetails: itemDetails2,
                      )));
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.network("${Urls.kBaseUrl}${itemDetails.image}"),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Calculate the font size based on the screen width
                  double fontSize = constraints.maxWidth * 0.05;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(itemDetails.name ?? "IDK",
                          style: TextStyle(fontSize: fontSize * 2)),
                      Text(itemDetails.seller_name?.toString() ?? "IDK",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                              color: Colors.grey)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹${itemDetails.price?.toString() ?? "IDK"}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize * 2)),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: fontSize / 3, right: fontSize / 3),
                                child: Text(itemDetails.rating.toString(),
                                    style: TextStyle(fontSize: fontSize)),
                              ),
                              RatingBarIndicator(
                                rating: itemDetails.rating ?? 0.0,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                itemCount: 5,
                                itemSize: fontSize * 2.3,
                                unratedColor: Colors.orange.withAlpha(50),
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
