<<<<<<< HEAD
import 'package:clothing_store_app/modules/CompleteProfileScreen/complete_profile_screen.dart';
import 'package:clothing_store_app/modules/LoginOrSignUpScreen/login_or_signup_screen.dart';
import 'package:clothing_store_app/modules/WelcomeScreen/welcome_screen.dart';
=======
import 'package:clothing_store_app/modules/email_for_new_pass_page.dart';
>>>>>>> fbe8c9f (all_login_forgetPass)
import 'package:flutter/material.dart';
import '../modules/OnBoardingScreen/on_boarding_screen.dart';

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

<<<<<<< HEAD
  Future<dynamic> pushWelcomeScreen() async {
    return _pushMaterialPageRoute(const WelcomeScreen());
  }

  Future<dynamic> pushOnBoardingScreen() async {
    return _pushMaterialPageRoute(const OnBoardingScreen());
  }

  Future<dynamic> pushSignUpScreen() async {
    return _pushMaterialPageRoute(LoginOrSignUpScreen(showLoginScreen: false));
  }

  Future<dynamic> pushLoginScreen() async {
    return _pushMaterialPageRoute(LoginOrSignUpScreen(showLoginScreen: true));
  }

  Future<dynamic> pushCompleteProfileScreen() async {
    return _pushMaterialPageRoute(const CompleteProfileScreen());
=======
  Future<dynamic> pushEmailForNewPassPage() async {
    return _pushMaterialPageRoute(const EmailForNewPassPage());
>>>>>>> fbe8c9f (all_login_forgetPass)
  }
}
