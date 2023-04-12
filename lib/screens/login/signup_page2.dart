import 'dart:math';

import 'package:definitely_not_amazon/provider/model/user_details_model.dart';
import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage2 extends StatefulWidget {
  SignupPage2(
      {Key? key,
      required this.email,
      required this.password1,
      required this.password2})
      : super(key: key);
  String email;
  String password1;
  String password2;

  @override
  State<SignupPage2> createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
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
                      width: max(MediaQuery.of(context).size.width * 0.3, 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                                padding: EdgeInsets.only(top: 8.0, left: 8),
                                child: Text('Almost Done',
                                    style: TextStyle(fontSize: 25)),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: firstNameController,
                              text: 'First Name',
                            ),
                            CustomTextField(
                              controller: lastNameController,
                              text: 'Last Name',
                            ),
                            CustomTextField(
                              controller: mobileController,
                              text: 'Mobile Number',
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                {
                                  final form = _formKey.currentState!;
                                  if (form.validate()) {
                                    try {
                                      await UserDetailsViewModel.createUser(
                                          UserLimitedDetailsModel(
                                        email: widget.email,
                                        password: widget.password1,
                                        confirm_password: widget.password2,
                                        first_name: firstNameController.text,
                                        last_name: lastNameController.text,
                                        mobile: mobileController.text,
                                      ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Successfully registered. Now login!"),
                                      ));
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/login', ModalRoute.withName('/'));
                                    } catch (e) {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/home', ModalRoute.withName('/'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
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
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
