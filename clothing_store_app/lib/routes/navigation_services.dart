import 'package:clothing_store_app/modules/CategoryScreen/category_screen.dart';
import 'package:clothing_store_app/modules/ChooseShippingScreen/choose_shipping_screen.dart';
import 'package:clothing_store_app/modules/AddNewShippingAddressScreen/add_new_shipping_address_screen.dart';
import 'package:clothing_store_app/modules/CompleteProfileScreen/complete_profile_screen.dart';
import 'package:clothing_store_app/modules/LoginOrSignUpScreen/login_or_signup_screen.dart';
import 'package:clothing_store_app/modules/PrivacyPolicyScreen/privacy_policy_screen.dart';
import 'package:clothing_store_app/modules/Profile/PaymentMethod/payment_method_screen.dart';
import 'package:clothing_store_app/modules/HelpCenterScreen/help_center_screen.dart';
import 'package:clothing_store_app/modules/Setting/password_manager_screen.dart';
import 'package:clothing_store_app/modules/Setting/setting_screen.dart';
import 'package:clothing_store_app/modules/Profile/UpdateProfile/update_profile_screen.dart';
import 'package:clothing_store_app/modules/Search/filter.dart';
import 'package:clothing_store_app/modules/Search/search_result.dart';
import 'package:clothing_store_app/modules/Search/search_screen.dart';
import 'package:clothing_store_app/modules/NotificationScreen/notification_screen.dart';
import 'package:clothing_store_app/modules/InviteFriendsScreen/invite_friends_screen.dart';
import 'package:clothing_store_app/modules/FriendRequestScreen/friend_request_screen.dart';
import 'package:clothing_store_app/modules/WelcomeScreen/welcome_screen.dart';
import 'package:clothing_store_app/modules/ForgotScreen/forgot_pass_page.dart';
import 'package:clothing_store_app/modules/PaymentMethodsScreen/payment_methods_screen.dart';
import 'package:clothing_store_app/modules/AddCardScreen/add_card_screen.dart';
import 'package:clothing_store_app/modules/ShippingAddressScreen/shipping_address_screen.dart';
import 'package:clothing_store_app/modules/PaymentSuccessfulScreen/payment_successful_screen.dart';
import 'package:clothing_store_app/modules/CheckoutScreen/checkout_screen.dart';
import 'package:clothing_store_app/class/order_info.dart';
import 'package:flutter/material.dart';
import '../modules/BottomNavigation/bottom_navigation_screen.dart';
import '../modules/Cart/my_cart.dart';
import '../modules/OnBoardingScreen/on_boarding_screen.dart';
import '../widgets/ordered_cloth_item.dart';
import '../routes/routes_name.dart';
import '../../utils/enum.dart';

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

  void pop({dynamic result}) {
    Navigator.pop(context, result);
  }

  void popToHomeScreen() {
    Navigator.of(context)
        .popUntil((route) => route.settings.name == RoutesName.homeScreen);
  }

  void popToMyOrder() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => BottomNavigationScreen(
          initialTab: BottomBarType.Shopping,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  void popToMyCart() {
    Navigator.of(context)
        .popUntil((route) => route.settings.name == RoutesName.myCart);
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

  Future<dynamic> pushUpdateProfileScreen(
      String username, String email, String phoneNumber) async {
    return _pushMaterialPageRoute(UpdateProfileScreen(
      username: username,
      email: email,
      phoneNumber: phoneNumber,
    ));
  }

  Future<dynamic> pushPaymentMethodScreen() async {
    return _pushMaterialPageRoute(const PaymentMethodScreen());
  }

  Future<dynamic> pushCategoryScreen(String type) async {
    return _pushMaterialPageRoute(CategoryScreen(
      categoryType: type,
    ));
  }

  Future<dynamic> pushAndRemoveUntilLoginScreen() async {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => LoginOrSignUpScreen(showLoginScreen: true)),
      (Route<dynamic> route) => false,
    );
  }

  Future<dynamic> gotoBottomTapScreen() async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationScreen(),
        settings: const RouteSettings(name: RoutesName.homeScreen),
      ),
    );
  }

  Future<dynamic> gotoCartScreen() async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCart(),
        settings: const RouteSettings(name: RoutesName.myCart),
      ),
    );
  }

  void gotoDetailOrderScreen(String orderID) async {
    return _pushMaterialPageRoute(DetailClothItem(orderID: orderID));
  }

  void gotoSearchScreen() async {
    return _pushMaterialPageRoute(const SearchScreen());
  }

  void gotoResultScreen(String searchText, RangeValues priceRange) async {
    return _pushMaterialPageRoute(
        SearchResultScreen(searchText: searchText, priceRange: priceRange));
  }

  void gotoFilterScreen() async {
    return _pushMaterialPageRoute(const FilterScreen());
  }

  Future<dynamic> pushNotificationScreen() async {
    return _pushMaterialPageRoute(const NotificationScreen());
  }

  Future<dynamic> pushInviteFriendsScreen() async {
    return _pushMaterialPageRoute(const InviteFriendsScreen());
  }

  Future<dynamic> pushFriendRequestScreen(String userID) async {
    return _pushMaterialPageRoute(FriendRequestScreen(userID: userID));
  }

  Future<dynamic> pushHelpCenterScreen() async {
    return _pushMaterialPageRoute(const HelpCenterScreen());
  }

  Future<dynamic> pushPrivacyPolicyScreen() async {
    return _pushMaterialPageRoute(const PrivacyPolicyScreen());
  }

  Future<dynamic> pushAddNewShippingAddressScreen() async {
    return _pushMaterialPageRoute(const AddNewShippingAddressScreen());
  }

  Future<dynamic> pushPaymentMethodsScreen(OrderInfo order) async {
    return _pushMaterialPageRoute(PaymentMethodsScreen(order: order));
  }

  Future<dynamic> pushAddCardScreen() async {
    return _pushMaterialPageRoute(const AddCardScreen());
  }

  Future<dynamic> pushShippingAddressScreen() async {
    return _pushMaterialPageRoute(const ShippingAddressScreen());
  }

  Future<dynamic> pushChooseShippingScreen(String shippingType) async {
    return _pushMaterialPageRoute(
        ChooseShippingScreen(selectedShippingType: shippingType));
  }

  Future<dynamic> pushPaymentSuccessfulScreen() async {
    return _pushMaterialPageRoute(const PaymentSuccessfulScreen());
  }

  Future<dynamic> pushCheckoutScreen(OrderInfo order) async {
    return _pushMaterialPageRoute(CheckoutScreen(order: order));
  }
}
