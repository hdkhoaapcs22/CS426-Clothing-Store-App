import 'package:flutter/material.dart';

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
}