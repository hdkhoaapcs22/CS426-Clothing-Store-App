import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  int chosenBrandIndex = 0;
  int chosenGenderIndex = 0;
  int chosenSortIndex = 0;
  var priceRange = const RangeValues(0, 150);
  String reviewpoint = '0';

  void updateBrandIndex(int i) {
    chosenBrandIndex = i;
    notifyListeners();
  }

  void updateGenderIndex(int i) {
    chosenGenderIndex = i;
    notifyListeners();
  }

  void updateSortIndex(int i) {
    chosenSortIndex = i;
    notifyListeners();
  }

  void updatePricerange(RangeValues newRange) {
    priceRange = newRange;
    notifyListeners();
  }

  void updateReviewOption(String rv) {
    reviewpoint = rv;
    notifyListeners();
  }

  void resetFilter() {
    chosenBrandIndex = 0;
    chosenGenderIndex = 0;
    chosenSortIndex = 0;
    priceRange = const RangeValues(0, 150);
    reviewpoint = '0';
    notifyListeners();
  }
}
