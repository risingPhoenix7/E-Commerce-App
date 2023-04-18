import 'dart:math';

import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class LeaveReviewScreen extends StatefulWidget {
  LeaveReviewScreen({Key? key}) : super(key: key);

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  TextEditingController detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<XFile> images = [];
  double rating = 5;

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
                              child: Text('Enter review details',
                                  style: TextStyle(fontSize: 25)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            controller: detailsController,
                            text: 'Short Title',
                          ),
                          CustomTextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            controller: detailsController,
                            text: 'Describe your experience',
                          ),
                          Center(
                            child: RatingBar.builder(
                                initialRating: rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    this.rating = rating;
                                  });
                                }),
                          ),
                          const SizedBox(height: 20),
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
                                    // widget.sellerItemDetails.description =
                                    //     detailsController.text;
                                    //
                                    // String output = SellerScreensViewModel
                                    //     .uploadSellerDetails(
                                    //         widget.sellerItemDetails, images);
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text(output),
                                    //   ),
                                    // );
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
