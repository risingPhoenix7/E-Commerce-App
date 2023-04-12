import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
        required this.controller,
        required this.text,
        this.removespacing = false,
        this.inputFormatters,
        this.keyboardType,
        this.validator,
        this.autofillHints})
      : super(key: key);

  final TextEditingController controller;
  final String text;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final bool removespacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        TextFormField(
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
          autofillHints: autofillHints,
          cursorColor: Colors.black,
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $text';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: text,
            hintStyle: TextStyle(color: Colors.black38),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        removespacing ? Container() : SizedBox(height: 10),
      ],
    );
  }
}
