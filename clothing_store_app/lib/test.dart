import 'package:clothing_store_app/modules/BottomNavigation/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationScreen()));
        },
        child: Text("Click me"),
      ),
    ));
  }
}
