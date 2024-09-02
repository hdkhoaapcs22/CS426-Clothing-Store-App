import 'package:clothing_store_app/modules/CompleteProfileScreen/complete_profile_screen.dart';
import 'package:clothing_store_app/modules/LoginOrSignUpScreen/login_or_signup_screen.dart';
import 'package:clothing_store_app/modules/Profile/PaymentMethod/payment_method_screen.dart';
import 'package:clothing_store_app/modules/Setting/password_manager_screen.dart';
import 'package:clothing_store_app/modules/Setting/setting_screen.dart';
import 'package:clothing_store_app/modules/Profile/UpdateProfile/update_profile_screen.dart';
import 'package:clothing_store_app/modules/WelcomeScreen/welcome_screen.dart';
import 'package:clothing_store_app/modules/ForgotScreen/forgot_pass_page.dart';
import 'package:flutter/material.dart';
import '../modules/BottomNavigation/bottom_navigation_screen.dart';
import '../modules/Cart/my_cart.dart';
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
    return _pushMaterialPageRoute(CompleteProfileScreen());
  }

  Future<dynamic> pushForgotPassPage() async {
    return _pushMaterialPageRoute(const ForgotPassPage());
  }

  Future<dynamic> pushSettingScreen() async {
    return _pushMaterialPageRoute(const SettingScreen());
  }

  Future<dynamic> pushPasswordManagerScreen() async {
    return _pushMaterialPageRoute(const PassWordManagerScreen());
  }

  Future<dynamic> pushUpdateProfileScreen(String username, String email, String phoneNumber) async {
    return _pushMaterialPageRoute(UpdateProfileScreen(
      username: username,
      email: email,
      phoneNumber: phoneNumber,
    ));
  }

  Future<dynamic> pushPaymentMethodScreen() async {
    return _pushMaterialPageRoute(const PaymentMethodScreen());
  }

  Future<dynamic> pushAndRemoveUntilLoginScreen() async {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => LoginOrSignUpScreen(showLoginScreen: true)),
      (Route<dynamic> route) => false,
    );
  }

  void gotoBottomTapScreen() async {
    return _pushMaterialPageRoute(const BottomNavigationScreen());
  }

  void gotoCartScreen() async {
    return _pushMaterialPageRoute(const MyCart());
  }
}
