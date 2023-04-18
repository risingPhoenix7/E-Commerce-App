import 'package:flutter/material.dart';

class ErrorDialogue extends StatelessWidget {
  const ErrorDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.error_outlined, color: Colors.red),
    );
  }
}
