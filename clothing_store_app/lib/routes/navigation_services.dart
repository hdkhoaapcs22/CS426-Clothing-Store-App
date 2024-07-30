import 'package:clothing_store_app/modules/CompleteProfileScreen/complete_profile_screen.dart';
import 'package:clothing_store_app/modules/LoginOrSignUpScreen/login_or_signup_screen.dart';
import 'package:clothing_store_app/modules/WelcomeScreen/welcome_screen.dart';
import 'package:clothing_store_app/modules/ForgotScreen/forgot_pass_page.dart';
import 'package:flutter/material.dart';
import '../modules/OnBoardingScreen/on_boarding_screen.dart';

class NavigationServices {
  final BuildContext context;
  NavigationServices(this.context);

  Future<dynamic> pushMaterialPageRoute(
    Widget widget, {
    bool fullscreenDialog = false,
    Future<void> Function(dynamic result)? onResult,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );

    if (onResult != null) {
      await onResult(result);
    }

    return result;
  }

  Future<dynamic> pushReplacementMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
          fullscreenDialog: fullscreenDialog,
        ));
  }

  void pop({dynamic result}) {
    Navigator.pop(context, result);
  }

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
  }

  Future<dynamic> pushForgotPassPage() async {
    return _pushMaterialPageRoute(const ForgotPassPage());
  }
}
