import 'package:clothing_store_app/modules/CompleteProfileScreen/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import '../modules/OnBoardingScreen/on_boarding_screen.dart';
import '../modules/SignUpScreen/sign_up_screen.dart';

class NavigationServices {
  final BuildContext context;
  NavigationServices(this.context);

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget, fullscreenDialog: fullscreenDialog));
  }

  Future<dynamic> pushOnBoardingScreen() async {
    return _pushMaterialPageRoute(const OnBoardingScreen());
  }

  Future<dynamic> pushSignUpScreen() async {
    return _pushMaterialPageRoute(const SignUpScreen());
  }

  Future<dynamic> pushCompleteProfileScreen() async {
    return _pushMaterialPageRoute(CompleteProfileScreen());
  }
}
