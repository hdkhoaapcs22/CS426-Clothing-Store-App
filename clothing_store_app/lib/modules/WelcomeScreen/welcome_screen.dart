import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../routes/navigation_services.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(70.0)),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(70.0)),
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
                      top: size.height / 3,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(Localfiles.asterisk),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: AppLocalizations(context).of("welcomeHeader1"),
                          style: TextStyles(context).getHeaderStyle(false)),
                      TextSpan(
                          text: AppLocalizations(context).of("welcomeHeader2"),
                          style: TextStyles(context).getHeaderStyle(true)),
                      TextSpan(
                          text: AppLocalizations(context).of("welcomeHeader3"),
                          style: TextStyles(context).getHeaderStyle(false)),
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations(context).of("welcomeDescript"),
                    style: TextStyles(context)
                        .getInterDescriptionStyle(false, false),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CommonButton(
                    onTap: () {
                      NavigationServices(context).pushOnBoardingScreen();
                    },
                    radius: 30.0,
                    backgroundColor: AppTheme.brownButtonColor,
                    buttonTextWidget: Text(
                      AppLocalizations(context).of("welcomeButtonText"),
                      style: TextStyles(context).getButtonTextStyle(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations(context).of("alreadyHaveAccount"),
                      style: TextStyles(context)
                          .getInterDescriptionStyle(false, false),
                    ),
                    TextButton(
                        onPressed: () {
                          NavigationServices(context).pushLoginScreen();
                        },
                        style: TextButton.styleFrom(
                          //overlayColor: Colors.transparent,
                        ),
                        child: Text(
                          AppLocalizations(context).of("signIn"),
                          style: TextStyles(context)
                              .getInterDescriptionStyle(true, true),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
