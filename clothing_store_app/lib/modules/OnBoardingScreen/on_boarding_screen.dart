import 'package:clothing_store_app/common/colors.dart';
import 'package:clothing_store_app/modules/OnBoardingScreen/on_boarding_widget.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../routes/navigation_services.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final TextStyle _headerBrownStyle = GoogleFonts.inter(
    fontSize: 25.0,
    fontWeight: FontWeight.w600,
    color: lightBrown1,
  );

  final TextStyle _headerNormalStyle = GoogleFonts.inter(
    fontSize: 25.0,
    fontWeight: FontWeight.w600,
    color: blackText,
  );

  final TextStyle _bodyBrownStyle = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: lightBrown2,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              OnBoardingWidget(
                imagePath: Localfiles.onBoarding1,
                header: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Seamless',
                      style: _headerBrownStyle
                    ),
                    TextSpan(
                      text: ' Shopping Experience',
                      style: _headerNormalStyle
                    ),
                  ],
                ),
                bodyText: "Welcome to the ultimate fashion destination! Discover trends, shop your favorite styles, and elevate your wardrobe. Let's get started on your stylish journey today",
                page: _currentPage,
                controller: _controller,
              ),
              OnBoardingWidget(
                imagePath: Localfiles.onBoarding2,
                header: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Wishlist: Where ',
                      style: _headerNormalStyle
                    ),
                    TextSpan(
                      text: 'Fashion Dreams ',
                      style: _headerBrownStyle
                    ),
                    TextSpan(
                      text: 'Begin',
                      style: _headerNormalStyle
                    ),
                  ],
                ),
                bodyText: "Your Wishlist awaits! Curate your dream looks and save favorites for later. It's the first step to making style aspirations a reality",
                page: _currentPage,
                controller: _controller,
              ),
              OnBoardingWidget(
                imagePath: Localfiles.onBoarding3,
                header: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Swift ',
                      style: _headerBrownStyle
                    ),
                    TextSpan(
                      text: 'and ',
                      style: _headerNormalStyle
                    ),
                    TextSpan(
                      text: 'Reliable ',
                      style: _headerBrownStyle
                    ),
                    TextSpan(
                      text: 'Delivery',
                      style: _headerNormalStyle
                    ),
                  ],
                ),
                bodyText: "Standard and Express delivery services are available for most of the countries that we ship to. ",
                page: _currentPage,
                controller: _controller,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _currentPage != 2
                    ? TextButton(
                        onPressed: () {
                          _controller.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                        },
                        child: Text(
                          "Skip",
                          style: _bodyBrownStyle,
                        ))
                    : null,
              ),
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _currentPage != 0 ? OutlinedButton(
                  onPressed: () => _controller.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  ),
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    foregroundColor: darkBrown,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: const Icon(Iconsax.arrow_left),
                ) : ElevatedButton(
                  onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent
                  ),
                  child: null),
                SmoothPageIndicator(
                  controller: _controller, 
                  count: 3,
                  effect: const ColorTransitionEffect(
                    activeDotColor: darkBrown,
                    dotWidth: 14.0,
                    dotHeight: 14.0,
                    radius: 14.0,
                  ),
                  ),
                ElevatedButton(
                  onPressed:() {
                    if (_currentPage == 2) {
                      NavigationServices(context).pushSignUpScreen();
                    }
                    else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200), 
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    backgroundColor: darkBrown,
                    foregroundColor:Colors.white,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: const Icon(Iconsax.arrow_right_1,)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}