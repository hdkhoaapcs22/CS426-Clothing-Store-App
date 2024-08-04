import 'dart:async';

import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import '../languages/appLocalizations.dart';
import '../routes/navigation_services.dart';
import '../services/auth/auth_service.dart';
import '../utils/localfiles.dart';
import '../utils/themes.dart';

// ignore: must_be_immutable
class SocialSignInButtons extends StatelessWidget {
  SocialSignInButtons({
    super.key, 
    required this.context,
  });

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.secondaryTextColor),
          borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {
              googleSignIn(this.context);
            },
            icon: const Image(
              width: 20,
              height: 20,
              image: AssetImage(Localfiles.googleLogo),
            ),
          ),
      ),
      const SizedBox(width: 16.0,),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.secondaryTextColor),
          borderRadius: BorderRadius.circular(100)),
        child: IconButton(
          onPressed: () {
          },
          icon: const Image(
            width: 20,
            height: 20,
            image: AssetImage(Localfiles.facebookLogo),
          ),
        ),
      ),
    ],);
  }

  Future<void> googleSignIn(BuildContext context) async {
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
    } catch (e) {
      print(e.toString());
    }
  }
}