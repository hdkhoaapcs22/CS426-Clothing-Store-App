import 'package:flutter/foundation.dart';

class WishlistProvider extends ChangeNotifier {
  int chosenIndex = 0;

  void update(int i) {
    chosenIndex = i;
    notifyListeners();
  }
}
