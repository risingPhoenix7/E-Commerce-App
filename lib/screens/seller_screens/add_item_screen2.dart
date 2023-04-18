import 'dart:math';

import 'package:definitely_not_amazon/screens/seller_screens/model/sellerItemDetails.dart';
import 'package:definitely_not_amazon/screens/seller_screens/viewmodel/uploadSellerDetails.dart';
import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage2 extends StatefulWidget {
  AddItemPage2({Key? key, required this.sellerItemDetails}) : super(key: key);
  SellerItemDetails sellerItemDetails;

  @override
  State<AddItemPage2> createState() => _AddItemPage2State();
}

class _AddItemPage2State extends State<AddItemPage2> {
  TextEditingController detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<XFile> images = [];

  Future<void> pickImages() async {
    List<XFile>? resultList = [];
    try {
      resultList = await ImagePicker().pickMultiImage();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error picking images'),
        ),
      );
      // handle exception
    }
    if (!mounted) return;
    setState(() {
      images = resultList ?? [];
    });
  }

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
                            controller: detailsController,
                            text: 'Item Details',
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[200],
                              ),
                              onPressed: () async {
                                List<XFile>? resultList = [];
                                try {
                                  resultList =
                                      await ImagePicker().pickMultiImage();
                                } on Exception catch (e) {
                                  // handle exception
                                }
                                if (!mounted) return;
                                setState(() {
                                  images = resultList ?? [];
                                });
                              },
                              child: const Text('Pick Images'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              final form = _formKey.currentState!;
                              if (form.validate()) {
                                if (images.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please pick atleast one image'),
                                    ),
                                  );
                                  return;
                                } else {
                                  try {
                                    widget.sellerItemDetails.description =
                                        detailsController.text;

                                    String output = SellerScreensViewModel
                                        .uploadSellerDetails(
                                            widget.sellerItemDetails, images);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(output),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Error uploading details'),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: Container(
                                color: Colors.orange,
                                height: 40,
                                width: double.infinity,
                                child: const Center(child: Text('Finish'))),
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
