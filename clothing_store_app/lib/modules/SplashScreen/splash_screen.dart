import 'package:flutter/material.dart';
import '../../utils/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
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
                )
              ),
            ),
            const SizedBox(width: 5.0,),
            Text(
              'fashion',
            style: TextStyles(context).getSplashScreenStyle(false, false)),
            Text('.',
            style: TextStyles(context).getSplashScreenStyle(false, true)),
          ],
        ),
      ),
    );
  }
}