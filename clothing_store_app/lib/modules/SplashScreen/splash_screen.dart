import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: GoogleFonts.dmSerifDisplay(
                    color: Colors.white,
                    fontSize: 35.0
                  )
                )
              ),
            ),
            const SizedBox(width: 5.0,),
            Text(
              'fashion',
            style: GoogleFonts.dmSerifDisplay(
              color: Colors.black,
              fontSize: 30.0
            )),
            Text('.',
            style: GoogleFonts.dmSerifDisplay(
              color: const Color.fromARGB(255, 107, 80, 59),
              fontSize: 30.0
            )),
          ],
        ),
      ),
    );
  }
}