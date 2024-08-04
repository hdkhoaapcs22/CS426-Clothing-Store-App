import 'package:clothing_store_app/modules/OnBoardingScreen/on_boarding_widget.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../languages/appLocalizations.dart';
import '../../routes/navigation_services.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

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
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      text: AppLocalizations(context).of("onBoardingHeader1.1"),
                      style: TextStyles(context).getLargerHeaderStyle(true),
                    ),
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader1.2"),
                      style: TextStyles(context).getLargerHeaderStyle(false),
                    ),
                  ],
                ),
                bodyText: AppLocalizations(context).of("onBoardingHeader1.body"),
                controller: _controller,
              ),
              OnBoardingWidget(
                imagePath: Localfiles.onBoarding2,
                header: TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader2.1"),
                      style: TextStyles(context).getLargerHeaderStyle(false),
                    ),
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader2.2"),
                      style: TextStyles(context).getLargerHeaderStyle(true),
                    ),
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader2.3"),
                      style: TextStyles(context).getLargerHeaderStyle(false),
                    ),
                  ],
                ),
                bodyText: AppLocalizations(context).of("onBoardingHeader2.body"),
                controller: _controller,
              ),
              OnBoardingWidget(
                imagePath: Localfiles.onBoarding3,
                header: TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader3.1"),
                      style: TextStyles(context).getLargerHeaderStyle(true),
                    ),
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader3.2"),
                      style: TextStyles(context).getLargerHeaderStyle(false),
                    ),
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader3.3"),
                      style: TextStyles(context).getLargerHeaderStyle(true),
                    ),
                    TextSpan(
                      text: AppLocalizations(context).of("onBoardingHeader3.4"),
                      style: TextStyles(context).getLargerHeaderStyle(false),
                    ),
                  ],
                ),
                bodyText: AppLocalizations(context).of("onBoardingHeader3.body"),
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
                          AppLocalizations(context).of("skip"),
                          style: TextStyles(context).getInterDescriptionStyle(true, false),
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
                  onPressed: () {
                    moveBackward();},
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    foregroundColor: AppTheme.brownButtonColor,
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
                  effect: ColorTransitionEffect(
                    activeDotColor: AppTheme.brownButtonColor,
                    dotWidth: 14.0,
                    dotHeight: 14.0,
                    radius: 14.0,
                  ),
                  ),
                ElevatedButton(
                  onPressed:() {
                    moveForward(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    backgroundColor: AppTheme.brownButtonColor,
                    foregroundColor:AppTheme.iconColor,
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

  void moveBackward() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void moveForward(BuildContext context) {
    if (_currentPage == 2) {
      NavigationServices(context).pushSignUpScreen();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }
}