import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void loading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      double lottieSize = MediaQuery.of(context).size.width * 0.2;
      return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Lottie.asset(
            'assets/json/loading_lottie.json',
            width: lottieSize,
          ));
    },
  );
}
