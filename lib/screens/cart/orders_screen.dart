import 'dart:math';

import 'package:definitely_not_amazon/screens/cart/model/viewCartItemsModel.dart';
import 'package:definitely_not_amazon/screens/cart/viewmodel/cart_viewmodel.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/search/view/search_screen.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:definitely_not_amazon/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    return CustomScaffold(
        body: isLoading
            ? const Loader()
            : Container(
                width: width,
                height: height,
                color: const Color(0xFFe8e3e3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                                orderItems.isEmpty
                                    ? Center(child: Text('No orders'))
                                    : Column(
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
                  ],
                ),
              ));
  }
}

class OrderItemWidget extends StatefulWidget {
  OrderItemWidget({Key? key, required this.orderItem}) : super(key: key);
  final OrderItem orderItem;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  Future<List<MiniItemDetails>> _getOrderDetails() async {
    return await CartViewModel.getOrderDetails(widget.orderItem.id!);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return GestureDetector(
      onTap: () async {
        try {
          List<MiniItemDetails> orderDetails = await _getOrderDetails();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(
                searchText: null,
                items: orderDetails,
              ),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade400),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${widget.orderItem.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '₹${widget.orderItem.amount}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment ID:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.orderItem.payment_uid ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceType == DeviceScreenType.mobile
                          ? width * 0.025
                          : 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
