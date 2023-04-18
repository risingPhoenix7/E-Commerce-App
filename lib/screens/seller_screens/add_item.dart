import 'dart:math';

import 'package:definitely_not_amazon/screens/seller_screens/model/sellerItemDetails.dart';
import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_item_screen2.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController mrpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'UPI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                              child: Text('Enter item details',
                                  style: TextStyle(fontSize: 25)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: nameController,
                            text: 'Item Name',
                          ),
                          CustomTextField(
                            controller: quantityController,
                            text: 'Stock Quantity',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+'),
                                replacementString: '',
                              )
                            ],
                          ),
                          CustomTextField(
                            controller: sellingPriceController,
                            text: 'Selling Price',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                              FilteringTextInputFormatter.deny(RegExp(r'-')),
                            ],
                          ),
                          CustomTextField(
                            controller: mrpController,
                            text: 'MRP',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                              FilteringTextInputFormatter.deny(RegExp(r'-')),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid value';
                              } else {
                                if (double.parse(value) <
                                    double.parse(sellingPriceController.text)) {
                                  return 'MRP cannot be less than selling price';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              final form = _formKey.currentState!;
                              if (form.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddItemPage2(
                                            sellerItemDetails:
                                                SellerItemDetails(
                                                    name: nameController.text,
                                                    mrp: double.parse(
                                                        mrpController.text),
                                                    quantity: int.parse(
                                                        quantityController
                                                            .text),
                                                    price: double.parse(
                                                        sellingPriceController
                                                            .text)))));
                              }
                            },
                            child: Container(
                                color: Colors.orange,
                                height: 40,
                                width: double.infinity,
                                child: const Center(child: Text('Next'))),
                          ),
                          const SizedBox(height: 20),
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
