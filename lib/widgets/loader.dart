import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 75,
        width: 75,
        child: SpinKitSpinningLines(
          color: Colors.amber,
        ),
      ),
    );
  }
}
