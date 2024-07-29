import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:clothing_store_app/modules/WelcomeScreen/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Color.fromARGB(255, 248, 244, 225),
          Color.fromARGB(255, 228, 197, 158),
          Color.fromARGB(255, 175, 143, 111),
          Color.fromARGB(255, 116, 81, 45),
        ],
      ),
      childWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              color: Color.fromARGB(255, 107, 80, 59),
            ),
            child: Center(
                child: Text(
              'f',
              style: TextStyles(context).getSplashScreenStyle(true, false),
            )),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text('fashion',
              style: TextStyles(context).getSplashScreenStyle(false, false)),
          Text('.',
              style: TextStyles(context).getSplashScreenStyle(false, true)),
        ],
      ),
      duration: const Duration(milliseconds: 2500),
      animationDuration: const Duration(milliseconds: 2000),
      nextScreen: const WelcomeScreen(),
    );
  }
}