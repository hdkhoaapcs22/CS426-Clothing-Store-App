import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  int chosenBrandIndex = 0;
  int chosenGenderIndex = 0;
  int chosenSortIndex = 0;
  var priceRange = const RangeValues(0, 150);
  String reviewpoint = '0';

  int get curBrand => chosenBrandIndex;
  int get curGender => chosenGenderIndex;
  int get curSort => chosenSortIndex;
  RangeValues get curPrice => priceRange;
  String get curReview => reviewpoint;

  void applyFilter(
      int brand, int gender, int sort, RangeValues price, String rv) {
    chosenBrandIndex = brand;
    chosenGenderIndex = gender;
    chosenSortIndex = sort;
    priceRange = price;
    reviewpoint = rv;
    notifyListeners();
  }
}
