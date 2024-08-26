import 'package:clothing_store_app/utils/enum.dart';
import 'package:flutter/material.dart';

class HomeTabNotifier extends ChangeNotifier{
  HomeTabType type = HomeTabType.All;
  String _index = 'All';
  String get index => _index;
  void setIndex(String index) {
    _index = index;
    switch (index) {
      case'All':
        setType(HomeTabType.All);
        break;
      case 'Newest':
        setType(HomeTabType.Newest);
        break;
      case 'Popular':
        setType(HomeTabType.Popular);
        break;
      case 'Man':
        setType(HomeTabType.Man);
        break;
      case 'Woman':
        setType(HomeTabType.Woman);
        break;
      case 'Kids':
        setType(HomeTabType.Kids);
        break;
      default:
        setType(HomeTabType.Kids);
    }
  }

  void setType(HomeTabType t) {
    type = t;
  }
}