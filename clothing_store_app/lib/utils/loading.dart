import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void loading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Lottie.asset('assets/json/loading_lottie.json',
            width: 100, height: 100),
      );
    },
  );
}
