import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HelperFunction{
  static Color? getColor(String value) {
    switch (value) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'yellow':
        return Colors.yellow;
      case 'grey':
        return Colors.grey;
      case 'brown':
        return Colors.brown;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'orange':
        return Colors.orange;
      case 'natural':
        return const Color.fromARGB(255, 247, 238, 211);
      case 'navy':
        return Colors.blueAccent;
      default:
        return null;
    }
  }

  static List<String> sortListOfSizes(List<String> allSizes) {
    final List<String> logicalSizeOrder = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

    allSizes.sort((a, b) {
      int indexA = logicalSizeOrder.indexOf(a);
      int indexB = logicalSizeOrder.indexOf(b);

      if (indexA == -1) indexA = logicalSizeOrder.length;
      if (indexB == -1) indexB = logicalSizeOrder.length;

      return indexA.compareTo(indexB);
    });

    return allSizes;
  }

  static IconData getIconForProfileServices(int index) {
    switch (index) {
      case 0:
        return Iconsax.user;
      case 1:
        return Iconsax.card;
      case 2:
        return Iconsax.clipboard_text;
      case 3:
        return Iconsax.setting_2;
      case 4:
        return Iconsax.info_circle;
      case 5:
        return Iconsax.lock4;
      case 6:
        return Iconsax.user_add;
      case 7:
        return Iconsax.logout_1;
      default:
        return Iconsax.user;
    }
  }

  static IconData getIconForSettingServices(int index) {
    switch (index) {
      case 0:
        return Iconsax.user;
      case 1:
        return Iconsax.key;
      case 2:
        return Iconsax.profile_remove;
      default:
        return Iconsax.user;
    }
  } 
}
