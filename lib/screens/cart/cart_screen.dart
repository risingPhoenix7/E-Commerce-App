import 'dart:math';

import 'package:definitely_not_amazon/screens/cart/add_payment_details.dart';
import 'package:definitely_not_amazon/screens/cart/model/viewCartItemsModel.dart';
import 'package:definitely_not_amazon/screens/cart/viewmodel/cart_viewmodel.dart';
import 'package:definitely_not_amazon/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = true;
  double totalPrice = 0;
  double factor = 1;
  TextEditingController couponController = TextEditingController();
  String? couponCode;

  getCartItems() async {
    try {
      await CartViewModel.getItemsInCart();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
    for (int i = 0; i < CartViewModel.cartItems.length; i++) {
      int quantity = CartViewModel.cartItems[i].quantity ?? 0;
      totalPrice =
          totalPrice + (CartViewModel.cartItems[i].price ?? 0.0 * quantity);
      totalPrice = totalPrice * factor;
    }
    setState(() {
      isLoading = false;
    });
  }

  calculateTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < CartViewModel.cartItems.length; i++) {
      int quantity = CartViewModel.cartItems[i].quantity ?? 0;
      totalPrice =
          totalPrice + (CartViewModel.cartItems[i].price ?? 0.0 * quantity);
      if (mounted) {
        setState(() {
          this.totalPrice = totalPrice * factor;
        });
      }
    }
  }

  @override
  void initState() {
    getCartItems();

    CartViewModel.refreshTotal.addListener(() {
      print('goes in here');
      calculateTotalPrice();
    });
    CartViewModel.removeItemFromCartListener.addListener(() {
      if (CartViewModel.removeItemFromCartListener.value == -1) {
        return;
      }
      for (int i = 0; i < CartViewModel.cartItems.length; i++) {
        if (CartViewModel.cartItems[i].item_id ==
            CartViewModel.removeItemFromCartListener.value) {
          CartViewModel.cartItems.removeAt(i);
          setState(() {});
          break;
        }
      }
    });
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
                              child: Text('My Cart',
                                  style: TextStyle(
                                      fontSize: fontSize * 2.5,
                                      fontWeight: FontWeight.bold)),
                            ),
                            CartViewModel.cartItems.isEmpty
                                ? const Center(child: Text("No items in cart"))
                                : Column(
                                    children: List.generate(
                                        CartViewModel.cartItems.length,
                                        (index) => CartItemWidget(
                                              cartItem: CartViewModel
                                                  .cartItems[index],
                                            )),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                CartViewModel.cartItems.isEmpty
                    ? Container()
                    : Expanded(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            Text('₹ $totalPrice ',
                                                style: TextStyle(
                                                    fontSize: fontSize * 1.2,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                          onPressed: () async {
                                            //TODO: Add payment details
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddPaymentPage(
                                                            couponCode:
                                                                couponCode)));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          controller: couponController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
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
                                          onPressed: () async {
                                            if (couponController.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please enter coupon code'),
                                              ));
                                            } else {
                                              try {
                                                double percentage =
                                                    await CartViewModel
                                                        .verifyCouponCode(
                                                            couponController
                                                                .text);
                                                couponCode =
                                                    couponController.text;
                                                factor = 1 - percentage / 100;
                                                setState(() {
                                                  calculateTotalPrice();
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Applied a discount of $percentage%"),
                                                ));
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(e.toString()),
                                                ));
                                                couponController.text = '';
                                              }
                                            }
                                          },
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

class CartItemWidget extends StatefulWidget {
  CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  CartItem cartItem;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  double totalPrice = 0.0;

  updateTotalPrice() {
    totalPrice = (widget.cartItem.price ?? 0.0) * widget.cartItem.quantity!;
    print('updated, notify listeners');
    CartViewModel.refreshTotal.notifyListeners();
  }

  @override
  void initState() {
    totalPrice = (widget.cartItem.price ?? 0.0) * widget.cartItem.quantity!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var fontSize = min(height * 0.02, width * 0.009);

    return Padding(
      padding: EdgeInsets.all(fontSize),
      child: Container(
        padding: EdgeInsets.all(fontSize),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: width * 0.125,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.cartItem.image ??
                          "https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.cartItem.name ?? "NA",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: fontSize * 1.6,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text("Store name",
                        style: TextStyle(
                            fontSize: fontSize * 1.2, color: Colors.grey)),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    //text description
                    SizedBox(
                      width: width * 0.3,
                      child: Text(widget.cartItem.description ?? "NA",
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
                            onPressed: () async {
                              if (widget.cartItem.quantity! > 1) {
                                try {
                                  await CartViewModel.addItemToCart(
                                      widget.cartItem.item_id!,
                                      widget.cartItem.quantity! - 1);
                                  widget.cartItem.quantity =
                                      widget.cartItem.quantity! - 1;
                                  updateTotalPrice();
                                  setState(() {});
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                  print(e);
                                }
                              }
                            },
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: Colors.black, fontSize: fontSize / 1),
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
                              widget.cartItem.quantity.toString(),
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
                            onPressed: () async {
                              try {
                                await CartViewModel.addItemToCart(
                                    widget.cartItem.item_id!,
                                    widget.cartItem.quantity! + 1);
                                widget.cartItem.quantity =
                                    widget.cartItem.quantity! + 1;
                                updateTotalPrice();
                                setState(() {});
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                                print(e);
                              }
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
                          onPressed: () async {
                            try {
                              await CartViewModel.addItemToCart(
                                  widget.cartItem.item_id!, 0);
                              CartViewModel.removeItemFromCartListener.value =
                                  widget.cartItem.item_id!;
                              CartViewModel.removeItemFromCartListener
                                  .notifyListeners();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                              print(e);
                            }
                          },
                          child: Text("Delete",
                              style: TextStyle(
                                  color: Colors.red, fontSize: fontSize * 1.2)),
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
                  Text('₹ ${widget.cartItem.price}',
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
                      Text('₹ $totalPrice ',
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
    );
  }
}
