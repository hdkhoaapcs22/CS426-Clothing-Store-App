import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';


Widget signInMethod(String imageLink, BuildContext context) {
  return TapEffect(
    onClick: () async {
      if (imageLink == Localfiles.googleIcon) {
        await AuthService().signInWithGoogle(context);
      } else {
        await AuthService().signInWithFacebook(context);
      }
    },
    child: CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            imageLink,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
