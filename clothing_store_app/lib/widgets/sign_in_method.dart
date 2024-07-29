import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';

Widget signInMethod(String imageLink) {
  return TapEffect(
    onClick: () {},
    child: CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey,
      child: CircleAvatar(
        radius: 39,
        backgroundColor: Colors.white,
        child: Image.asset(
          imageLink,
          width: 36,
          height: 36,
        ),
      ),
    ),
  );
}
