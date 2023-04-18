import 'dart:math';

import 'package:definitely_not_amazon/screens/login/signup_page2.dart';
import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({Key? key}) : super(key: key);

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'UPI';

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
                                    value: 'CREDIT',
                                    groupValue: _paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _paymentMethod = value!;
                                      });
                                    },
                                  ),
                                  Text('Credit'),
                                  Radio(
                                    value: 'DEBIT',
                                    groupValue: _paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _paymentMethod = value!;
                                      });
                                    },
                                  ),
                                  Text('Debit'),
                                  Radio(
                                    value: 'UPI',
                                    groupValue: _paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _paymentMethod = value!;
                                      });
                                    },
                                  ),
                                  Text('UPI'),
                                  Radio(
                                    value: 'bank_transfer',
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
                                if (passwordController.text !=
                                    passwordController2.text) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("Password fields don't match"),
                                  ));
                                } else {
                                  final form = _formKey.currentState!;
                                  if (form.validate()) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => SignupPage2(
                                                password2:
                                                    passwordController2.text,
                                                password1:
                                                    passwordController.text,
                                                email: uidController.text)));
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
