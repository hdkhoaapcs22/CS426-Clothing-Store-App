import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';

Widget signInMethod(String imageLink, BuildContext context) {
  return TapEffect(
    onClick: () {
      if (imageLink == Localfiles.googleIcon) {
        googleSignIn(context);
      }
    },
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

Future<String?> googleSignIn(BuildContext context) async {
  try {
    Dialogs(context).showLoadingDialog();
    String? userId = await AuthService().signInWithGoogle();
    Navigator.of(context).pop();
    if (userId != null) {
      await Dialogs(context).showAnimatedDialog(
          title: AppLocalizations(context).of("success"),
          content: AppLocalizations(context).of("register_successfully"));
      NavigationServices(context).pushCompleteProfileScreen();
    }
    return userId;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
