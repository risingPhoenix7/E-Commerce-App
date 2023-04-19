import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/cart/orders_screen.dart';
import 'package:definitely_not_amazon/screens/seller_screens/viewAllItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'edit_general.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Profile',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 50),
            CustomContainerWidget(
              screen: EditGeneral(
                  intnumber: 0,
                  editgenerallist: [
                    EditGeneralInput(
                        name: 'First Name',
                        isCompulsory: true,
                        givenString: "first_name",
                        currentValue:
                            UserDetailsViewModel.userDetailsModel?.first_name ??
                                ""),
                    EditGeneralInput(
                        name: 'Last Name',
                        givenString: "last_name",
                        isCompulsory: true,
                        currentValue:
                            UserDetailsViewModel.userDetailsModel?.last_name ??
                                ""),
                    EditGeneralInput(
                        name: 'Age',
                        givenString: "age",
                        isCompulsory: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        currentValue:
                            UserDetailsViewModel.userDetailsModel?.age ?? ""),
                    EditGeneralInput(
                        name: 'Sex',
                        givenString: "sex",
                        isCompulsory: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[MFO]')),
                          //LIMIT TO ONE CHARACTER
                          LengthLimitingTextInputFormatter(1)
                        ],
                        currentValue:
                            UserDetailsViewModel.userDetailsModel?.sex ?? ""),
                  ],
                  title: 'Edit Bio Data'),
              name: 'Edit Bio Data',
            ),
            CustomContainerWidget(
              screen: EditGeneral(
                  intnumber: 1,
                  editgenerallist: [
                    EditGeneralInput(
                        name: 'Store Name',
                        isCompulsory: false,
                        givenString: "store_name",
                        currentValue:
                            UserDetailsViewModel.userDetailsModel?.store_name ??
                                ""),
                    EditGeneralInput(
                        name: 'Address 1',
                        isCompulsory: false,
                        givenString: "store_address1",
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.store_address1 ??
                            ""),
                    EditGeneralInput(
                        name: 'Address 2',
                        isCompulsory: false,
                        givenString: "store_address2",
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.store_address2 ??
                            ""),
                    EditGeneralInput(
                        name: 'City',
                        isCompulsory: false,
                        givenString: "store_city",
                        currentValue:
                            UserDetailsViewModel.userDetailsModel?.store_city ??
                                ""),
                    EditGeneralInput(
                        name: 'Country',
                        isCompulsory: false,
                        givenString: "store_country",
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.store_country ??
                            ""),
                    EditGeneralInput(
                        name: 'Pincode',
                        givenString: "store_pincode",
                        isCompulsory: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.store_pincode ??
                            ""),
                  ],
                  title: 'Edit Warehouse Address'),
              name: 'Edit Warehouse Address',
            ),
            CustomContainerWidget(
              screen: EditGeneral(
                  intnumber: 2,
                  editgenerallist: [
                    EditGeneralInput(
                        name: 'Address 1',
                        givenString: "delivery_address1",
                        isCompulsory: false,
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.delivery_address1 ??
                            ""),
                    EditGeneralInput(
                        name: 'Address 2',
                        givenString: "delivery_address2",
                        isCompulsory: false,
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.delivery_address2 ??
                            ""),
                    EditGeneralInput(
                        name: 'City',
                        givenString: "delivery_city",
                        isCompulsory: false,
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.delivery_city ??
                            ""),
                    EditGeneralInput(
                        name: 'Country',
                        givenString: "delivery_country",
                        isCompulsory: false,
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.delivery_country ??
                            ""),
                    EditGeneralInput(
                        name: 'Pincode',
                        givenString: "delivery_pincode",
                        isCompulsory: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        currentValue: UserDetailsViewModel
                                .userDetailsModel?.delivery_pincode ??
                            ""),
                  ],
                  title: 'Edit Delivery Address'),
              name: 'Edit Delivery Address',
            ),
            CustomContainerWidget(
              screen: OrdersScreen(),
              name: 'View orders',
            ),
            CustomContainerWidget(
              screen: SellerViewItemsScreen(),
              name: 'Go to seller home page',
            ),
            GestureDetector(
              onTap: () async {
                await UserDetailsViewModel.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Container(
                height: 100,
                width: 300,
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
                child: Center(child: Text("Logout")),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}

class CustomContainerWidget extends StatelessWidget {
  CustomContainerWidget({Key? key, required this.screen, required this.name})
      : super(key: key);
  Widget screen;
  String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        height: 100,
        width: 300,
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
        child: Center(child: Text(name)),
      ),
    );
  }
}
