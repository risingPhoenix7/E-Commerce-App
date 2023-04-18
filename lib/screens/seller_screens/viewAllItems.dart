import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/screens/profile/profile_screen.dart';
import 'package:definitely_not_amazon/screens/seller_screens/add_item.dart';
import 'package:definitely_not_amazon/screens/seller_screens/viewmodel/uploadSellerDetails.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:definitely_not_amazon/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'editItemDetailsScreen.dart';

class SellerViewItemsScreen extends StatefulWidget {
  SellerViewItemsScreen({Key? key}) : super(key: key);

  @override
  State<SellerViewItemsScreen> createState() => _SellerViewItemsScreenState();
}

class _SellerViewItemsScreenState extends State<SellerViewItemsScreen> {
  bool isLoading = true;
  List<ItemDetails> items = [];

  getSellerItems() async {
    try {
      items = await SellerScreensViewModel.getSellerItems();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getSellerItems();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    return CustomScaffold(
        title: "Your items",
        body: isLoading
            ? Loader()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // add item button in the right corner
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (UserDetailsViewModel.userDetailsModel?.store_address1 == null ||
                              UserDetailsViewModel
                                      .userDetailsModel?.store_address2 ==
                                  null ||
                              UserDetailsViewModel
                                  .userDetailsModel!.store_address2!.isEmpty ||
                              UserDetailsViewModel
                                  .userDetailsModel!.store_address1!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please add your store address first")));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomScaffold(
                                      body: const ProfileScreen(),
                                      title: "Profile"),
                                ));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddItemPage()));
                          }
                        },
                        child: const Text("Add item"),
                      ),
                    ),
                  ),
                  items.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("No items selling/sold")))
                      : Expanded(
                          child: GridView.builder(
                            itemCount: items.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        deviceType == DeviceScreenType.mobile
                                            ? 2
                                            : 4),
                            itemBuilder: (BuildContext context, int index) {
                              return SellerItemDetailsCard(
                                  itemDetails: items[index]);
                            },
                          ),
                        )
                ],
              ));
  }
}

class SellerItemDetailsCard extends StatelessWidget {
  const SellerItemDetailsCard({Key? key, required this.itemDetails})
      : super(key: key);
  final ItemDetails itemDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditItemDetailsScreen(
                        itemDetails: itemDetails,
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
                child: Image.network(
                    "${itemDetails.images?[0] ?? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fno-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-image132482953&psig=AOvVaw0uyzFH2pH9op8vngJgMBRs&ust=1681911455790000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCOCFqMXGs_4CFQAAAAAdAAAAABAI"}"),
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
