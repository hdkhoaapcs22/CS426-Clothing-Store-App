import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChooseCouponProvider extends ChangeNotifier {
  bool initialized = false;
  List<bool> chosenCoupon = [];

  void updateChosenCoupon(int i) {
    chosenCoupon[i] = !chosenCoupon[i];
    notifyListeners();
  }

  void initializeCoupon(int num) {
    chosenCoupon = List<bool>.filled(num, false);
    initialized = true;
  }
}
