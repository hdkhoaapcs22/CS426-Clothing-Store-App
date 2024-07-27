import 'package:clothing_store_app/common/colors.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/navigation_services.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextStyle _headerBrownStyle = GoogleFonts.inter(
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
    color: lightBrown1,
  );

  final TextStyle _headerNormalStyle = GoogleFonts.inter(
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
    color: blackText,
  );

  final TextStyle _bodyStyle = GoogleFonts.inter(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    color: greyText,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(70.0),
                              topRight: Radius.circular(70.0),
                              bottomRight: Radius.circular(70.0),
                              bottomLeft: Radius.circular(70.0),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                Localfiles.welcomeImage1,
                                height: size.height / 2.5,
                                width: size.width / 2.5,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(60.0),
                                topRight: Radius.circular(60.0),
                                bottomRight: Radius.circular(60.0),
                                bottomLeft: Radius.circular(60.0),
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  Localfiles.welcomeImage2,
                                  height: size.height / 5,
                                  width: size.width / 3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            ClipOval(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  Localfiles.welcomeImage3,
                                  height: size.height / 6,
                                  width: size.width / 3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      left: 8.0,
                      top: size.height/3,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(Localfiles.asterisk),
                      ),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "The ", style: _headerNormalStyle),
                      TextSpan(
                          text: "Fashion App ", style: _headerBrownStyle),
                      TextSpan(
                          text: "That Makes You Look Your Best",
                          style: _headerNormalStyle),
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Welcome to fashion app! Discover trends, shop favorite styles, and elevate your wardrobe. Let's get started",
                    style: _bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0,),
                //new button with tap effect
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CommonButton(
                      onTap: () {
                        NavigationServices(context).pushOnBoardingScreen();
                      },
                      radius: 30.0,
                      backgroundColor: darkBrown,
                      buttonText: 'Let\'s Get Started',
                      buttonTextWidget: Text(
                        "Let's Get Started",
                        style: GoogleFonts.inter(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                      ),
                    ),
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: _bodyStyle,
                    ),
                    TextButton(
                        onPressed: () {
                          //SIGN IN
                        },
                        child: Text(
                          "Sign in",
                          style: GoogleFonts.inter(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: darkBrown,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
