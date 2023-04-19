import 'dart:math';

import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'orders_screen.dart';
import 'viewmodel/cart_viewmodel.dart';

class AddPaymentPage extends StatefulWidget {
  AddPaymentPage({Key? key, this.couponCode}) : super(key: key);
  String? couponCode;

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod='';

  TextEditingController uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', ModalRoute.withName('/'));
                  },
                  child: Image.asset(
                    'assets/images/logo_white.png',
                    // Replace with your logo URL
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    width: max(MediaQuery.of(context).size.width * 0.3, 400),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0, left: 8, bottom: 10),
                              child: Text('Enter payment details',
                                  style: TextStyle(fontSize: 25)),
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            heading: "Transaction ID",
                            controller: uidController,
                            text: 'Enter your transaction ID',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid UID of your transaction';
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Payment Method:',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'credit',
                                    groupValue: _paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _paymentMethod = value!;
                                      });
                                    },
                                  ),
                                  Text('Credit'),
                                  Radio(
                                    value: 'debit',
                                    groupValue: _paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _paymentMethod = value!;
                                      });
                                    },
                                  ),
                                  Text('Debit'),
                                  Radio(
                                    value: 'upi',
                                    groupValue: _paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _paymentMethod = value!;
                                      });
                                    },
                                  ),
                                  Text('UPI'),
                                  Radio(
                                    value: 'bank transfer',
                                    groupValue: _paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _paymentMethod = value!;
                                      });
                                    },
                                  ),
                                  Text('Bank Transfer'),
                                ],
                              ),
                              SizedBox(height: 16.0),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              {
                                if (_paymentMethod.isEmpty ||
                                    uidController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill all the fields'),
                                    ),
                                  );
                                } else {
                                  final form = _formKey.currentState!;
                                  if (form.validate()) {
                                    try {
                                      await CartViewModel.placeOrder(
                                          _paymentMethod,
                                          uidController.text,
                                          widget.couponCode);
                                      CartViewModel.cartCount.value = 0;
                                      CartViewModel.totalPrice.value = 0;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text('Order placed successfully'),
                                      ));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OrdersScreen()));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
                                    }
                                  }
                                }
                              }
                            },
                            child: Container(
                                color: Colors.orange,
                                height: 40,
                                width: double.infinity,
                                child:
                                    const Center(child: Text('Place order'))),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
