import 'package:clothing_store_app/modules/Chat/chatting_screen.dart';
import 'package:clothing_store_app/modules/Favorite/favorite_screen.dart';
import 'package:clothing_store_app/modules/Profile/profile_screen.dart';
import 'package:clothing_store_app/modules/Shop/shopping_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/enum.dart';
import '../Home/home_screen.dart';

class SwitchBottomNavigationComponent {
  static final SwitchBottomNavigationComponent _instance =
      SwitchBottomNavigationComponent._internal();

  SwitchBottomNavigationComponent._internal();

  factory SwitchBottomNavigationComponent() => _instance;

  Widget switchBottomNavigationComponent(
      {required BottomBarType bottomBarType,
      required AnimationController animationController}) {
    switch (bottomBarType) {
      case BottomBarType.Home:
        return HomeScreen(animationController: animationController);
      case BottomBarType.Shopping:
        return ShoppingScreen(animationController: animationController);
      case BottomBarType.Favorite:
        return FavoriteScreen(animationController: animationController);
      case BottomBarType.Chatting:
        return ChattingScreen(animationController: animationController);
      case BottomBarType.Profile:
        return ProfileScreen(animationController: animationController);
    }
  }
}
