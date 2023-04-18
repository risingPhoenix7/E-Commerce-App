import 'dart:math';

import 'package:definitely_not_amazon/screens/cart/model/viewCartItemsModel.dart';
import 'package:definitely_not_amazon/screens/cart/viewmodel/cart_viewmodel.dart';
import 'package:definitely_not_amazon/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'add_payment_details.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isLoading = true;
  List<OrderItem> orderItems = [];

  getOrderItems() async {
    try {
      orderItems = await CartViewModel.getOrders();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getOrderItems();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var fontSize = min(height * 0.02, width * 0.01);
    return isLoading
        ? const Loader()
        : Container(
            width: width,
            height: height,
            color: const Color(0xFFe8e3e3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: height * 0.8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text('My Orders',
                                  style: TextStyle(
                                      fontSize: fontSize * 2.5,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Column(
                              children: List.generate(
                                  orderItems.length,
                                  (index) => OrderItemWidget(
                                        orderItem: orderItems[index],
                                      )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 20, bottom: 20),
                          child: Container(
                              height: height * 0.2,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Subtotal (1 item): ',
                                            style: TextStyle(
                                              fontSize: fontSize * 1.2,
                                            )),
                                        Text('₹ 56.02 ',
                                            style: TextStyle(
                                                fontSize: fontSize * 1.2,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddPaymentPage()));
                                      },
                                      child: Text(
                                        "Proceed to checkout",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height * 0.02),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                              height: height * 0.24,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text('Add coupon code',
                                        style: TextStyle(
                                          fontSize: fontSize * 1.2,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.05),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.05,
                                    width: width * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Verify",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height * 0.02),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ))
              ],
            ),
          );
  }
}

class OrderItemWidget extends StatelessWidget {
  OrderItemWidget({Key? key, required this.orderItem}) : super(key: key);
  OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(orderItem.id.toString()),
          Text(orderItem.amount.toString()),
          Text(orderItem.payment_uid.toString()),
          Text(orderItem.created_at.toString())
        ],
      ),
    );
  }
}
