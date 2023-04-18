import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var fontSize = min(height * 0.02, width * 0.01);
    return Container(
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
                        child: Text('My Cart',
                            style: TextStyle(
                                fontSize: fontSize * 2.5,
                                fontWeight: FontWeight.bold)),
                      ),
                      CartItemWidget(),
                      CartItemWidget(),
                      CartItemWidget(),
                      CartItemWidget(),
                      CartItemWidget(),
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
                    padding:
                        const EdgeInsets.only(right: 20, top: 20, bottom: 20),
                    child: Container(
                        height: height * 0.2,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {},
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
                  Container(
                      height: height * 0.24,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('Add coupon code',
                                style: TextStyle(
                                  fontSize: fontSize * 1.2,
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Container(
                            height: height * 0.05,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
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
                      ))
                ],
              ))
        ],
      ),
    );
  }
}

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({Key? key}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var fontSize = min(height * 0.02, width * 0.009);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: height * 0.35,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: width * 0.2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://m.media-amazon.com/images/I/81tjLksKixL._AC_AA360_.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Apple iPhone 11 (64GB) - Black',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: fontSize * 1.6,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text('Apple',
                          style: TextStyle(
                              fontSize: fontSize * 1.2, color: Colors.grey)),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      //text description
                      SizedBox(
                        width: width * 0.3,
                        child: Text(
                            'The iPhone 11 is a smartphone designed, developed, and marketed by Apple Inc. It is the twelfth generation of the iPhone. It was announced on September 10, 2019, alongside the higher-end iPhone 11 Pro and iPhone 11 Pro Max, at the Steve Jobs Theater in the Apple Park campus.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: fontSize * 1.2, color: Colors.grey)),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: fontSize / 1),
                              ),
                            ),
                          ),
                          //a quantity textfield here
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontSize,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Delete",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: fontSize * 1.2)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹ 56.02 ',
                        style: TextStyle(
                            fontSize: fontSize * 1.6,
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
