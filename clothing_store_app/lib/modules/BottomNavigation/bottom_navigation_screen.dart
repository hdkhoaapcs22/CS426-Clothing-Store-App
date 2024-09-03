import 'package:clothing_store_app/modules/Home/home_screen.dart';
import 'package:clothing_store_app/modules/MyOrder/my_order.dart';
import 'package:clothing_store_app/modules/Wishlist/wishlist_page.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/enum.dart';
import '../Chat/introduction_chatting.dart';
import '../Profile/profile_screen.dart';
import 'custom_bottom_tap.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Widget indexView;
  late BottomBarType bottomBarType;
  bool isFirstTime = true;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    bottomBarType = BottomBarType.Home;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startLoadingScreen();
    });
    super.initState();
  }

  Future startLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() {
      isFirstTime = false;
      indexView = HomeScreen(
        animationController: animationController,
      );
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) => Scaffold(
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height * 0.075,
            child: getBottomBarUI(bottomBarType),
          ),
          body: isFirstTime
              ? Center(
                  child: Container(
                    child: Lottie.asset(Localfiles.loading),
                  ),
                )
              : indexView),
    );
  }

  getBottomBarUI(BottomBarType bottomBarType) {
    return Card(
      color: const Color.fromARGB(255, 36, 39, 54),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            TabButtonUI(
              icon: Icons.house_outlined,
              iconSelected: Icons.house,
              isSelected: bottomBarType == BottomBarType.Home,
              onTap: () {
                tabClick(BottomBarType.Home);
              },
            ),
            TabButtonUI(
              icon: Icons.shopping_bag_outlined,
              iconSelected: Icons.shopping_bag,
              isSelected: bottomBarType == BottomBarType.Shopping,
              onTap: () {
                tabClick(BottomBarType.Shopping);
              },
            ),
            TabButtonUI(
              icon: Icons.favorite_border_outlined,
              iconSelected: Icons.favorite,
              isSelected: bottomBarType == BottomBarType.Wishlist,
              onTap: () {
                tabClick(BottomBarType.Wishlist);
              },
            ),
            TabButtonUI(
              icon: Icons.message_outlined,
              iconSelected: Icons.message,
              isSelected: bottomBarType == BottomBarType.Chatting,
              onTap: () {
                tabClick(BottomBarType.Chatting);
              },
            ),
            TabButtonUI(
              icon: Icons.person_outline,
              iconSelected: Icons.person,
              isSelected: bottomBarType == BottomBarType.Profile,
              onTap: () {
                tabClick(BottomBarType.Profile);
              },
            ),
          ],
        ),
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then((value) {
        switch (bottomBarType) {
          case BottomBarType.Home:
            {
              indexView = HomeScreen(
                animationController: animationController,
              );
            }
          case BottomBarType.Shopping:
            {
              indexView = MyOrder(animationController: animationController);
            }
          case BottomBarType.Wishlist:
            {
              indexView =
                  WishlistPage(animationController: animationController);
            }
          case BottomBarType.Chatting:
            {
              indexView = IntroductionChattingInterface(
                  animationController: animationController);
            }
          case BottomBarType.Profile:
            {
              indexView =
                  ProfileScreen(animationController: animationController);
            }
        }
        setState(() {});
      });
    }
  }
}
