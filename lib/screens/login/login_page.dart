import 'dart:math';

import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/home/home_screen.dart';
import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> login(String username, String password) async {
    await UserDetailsViewModel.getUserDetails(
        emailController.text, passwordController.text);
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
                GestureDetector(
                  onTap: () {
                    print('Logo tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
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
                    height: max(MediaQuery.of(context).size.height * 0.5, 400),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0, left: 8),
                              child: Text('Sign in',
                                  style: TextStyle(fontSize: 25)),
                            ),
                          ),
                          CustomTextField(
                            controller: emailController,
                            removespacing: true,
                            keyboardType: TextInputType.emailAddress,
                            text: 'Email',
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                              controller: passwordController,
                              text: "Password",
                              removespacing: true),
                          GestureDetector(
                            onTap: () async {
                              {
                                final form = _formKey.currentState!;
                                if (form.validate()) {
                                  try {
                                    await login(emailController.text,
                                        passwordController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Logged in successfully')));
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        '/home', ModalRoute.withName('/'));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Invalid email or password')));
                                  }
                                }
                              }
                            },
                            child: Container(
                                color: Colors.orange,
                                height: 40,
                                width: double.infinity,
                                child: const Center(child: Text('Log in'))),
                          ),
                          Row(
                            children: [
                              const Text('New here? '),
                              GestureDetector(
                                child: const Text('Signup',
                                    style: TextStyle(color: Colors.blue)),
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                              ),
                            ],
                          )
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
