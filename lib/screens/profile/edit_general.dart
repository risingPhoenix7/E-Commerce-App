import 'dart:convert';
import 'dart:math';

import 'package:definitely_not_amazon/screens/profile/changeDetailsViewModel.dart';
import 'package:definitely_not_amazon/screens/profile/profile_screen.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditGeneral extends StatefulWidget {
  EditGeneral(
      {Key? key,
      required this.editgenerallist,
      required this.title,
      required this.intnumber})
      : super(key: key);
  List<EditGeneralInput> editgenerallist;
  String title;
  int intnumber;

  @override
  State<EditGeneral> createState() => _EditGeneralState();
}

class _EditGeneralState extends State<EditGeneral> {
  @override
  void initState() {
    for (int i = 0; i < widget.editgenerallist.length; i++) {
      widget.editgenerallist[i].controller = TextEditingController(
          text: widget.editgenerallist[i].currentValue.toString());
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8, bottom: 10),
                              child: Text(widget.title,
                                  style: const TextStyle(fontSize: 25)),
                            ),
                          ),
                          Column(
                            children: widget.editgenerallist
                                .map((e) => CustomTextField(
                                      text: e.name,
                                      controller: e.controller!,
                                      validator: e.isCompulsory
                                          ? null
                                          : (value) {
                                              if (value!.isEmpty) {
                                                return null;
                                              }
                                              return null;
                                            },
                                      inputFormatters: e.inputFormatters,
                                      keyboardType: e.keyboardType,
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              {
                                {
                                  final form = _formKey.currentState!;
                                  if (form.validate()) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => CustomScaffold(
                                                body: const ProfileScreen())));
                                  }
                                }
                              }
                            },
                            child: GestureDetector(
                              onTap: () async {
                                {
                                  {
                                    final form = _formKey.currentState!;
                                    if (form.validate()) {
                                      Map<String, dynamic> keyValueMap = {};

                                      for (EditGeneralInput item
                                          in widget.editgenerallist) {
                                        keyValueMap[item.givenString] =
                                            item.controller?.text.toString() ??
                                                '';
                                      }
                                      try {
                                        print(jsonEncode(keyValueMap));
                                        if (widget.intnumber == 0) {
                                          await ChangeDetailsViewModel
                                              .changeUserDetails(keyValueMap);
                                        } else if (widget.intnumber == 1) {
                                          await ChangeDetailsViewModel
                                              .changeSellerDetails(keyValueMap);
                                        } else if (widget.intnumber == 2) {
                                          await ChangeDetailsViewModel
                                              .changeCustomerDetails(
                                                  keyValueMap);
                                        }
                                        await ChangeDetailsViewModel
                                            .updateProfile();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Details successfully changed')));
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Error occured, please try again later')));
                                      }

                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/home', ModalRoute.withName('/'));
                                    }
                                  }
                                }
                              },
                              child: Container(
                                  color: Colors.orange,
                                  height: 40,
                                  width: double.infinity,
                                  child: const Center(child: Text('Save'))),
                            ),
                          ),
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

class EditGeneralInput {
  String name;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  bool isCompulsory = false;
  TextEditingController? controller;
  var currentValue;
  String givenString;

  EditGeneralInput(
      {required this.name,
      this.inputFormatters,
      this.keyboardType,
      this.controller,
      required this.givenString,
      this.currentValue,
      required this.isCompulsory});
}
