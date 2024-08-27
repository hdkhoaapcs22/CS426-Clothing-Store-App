import 'package:clothing_store_app/modules/ChooseShippingScreen/choose_shipping_screen.dart';
import 'package:clothing_store_app/modules/CompleteProfileScreen/complete_profile_screen.dart';
import 'package:clothing_store_app/modules/LoginOrSignUpScreen/login_or_signup_screen.dart';
import 'package:clothing_store_app/modules/WelcomeScreen/welcome_screen.dart';
import 'package:clothing_store_app/modules/ForgotScreen/forgot_pass_page.dart';
import 'package:clothing_store_app/modules/PaymentMethodsScreen/payment_methods_screen.dart';
import 'package:clothing_store_app/modules/AddCardScreen/add_card_screen.dart';
import 'package:clothing_store_app/modules/ShippingAddressScreen/shipping_address_screen.dart';
import 'package:clothing_store_app/modules/PaymentSuccessfulScreen/payment_successful_screen.dart';
import 'package:clothing_store_app/modules/CheckoutScreen/checkout_screen.dart';
import 'package:clothing_store_app/class/order.dart';
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

  void gotoBottomTapScreen() async {
    return _pushMaterialPageRoute(const BottomNavigationScreen());
  }

  void gotoCartScreen() async {
    return _pushMaterialPageRoute(const MyCart());
  }

  Future<dynamic> pushPaymentMethodsScreen() async {
    return _pushMaterialPageRoute(const PaymentMethodsScreen());
  }

  Future<dynamic> pushAddCardScreen() async {
    return _pushMaterialPageRoute(const AddCardScreen());
  }

  Future<dynamic> pushShippingAddressScreen() async {
    return _pushMaterialPageRoute(const ShippingAddressScreen());
  }

  Future<dynamic> pushChooseShippingScreen() async {
    return _pushMaterialPageRoute(const ChooseShippingScreen());
  }

  Future<dynamic> pushPaymentSuccessfulScreen() async {
    return _pushMaterialPageRoute(const PaymentSuccessfulScreen());
  }

  Future<dynamic> pushCheckoutScreen(Order order) async {
    return _pushMaterialPageRoute(CheckoutScreen(order: order));
  }

}
