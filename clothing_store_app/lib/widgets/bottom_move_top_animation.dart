import 'package:flutter/material.dart';

class BottomMoveTopAnimation extends StatelessWidget {
  final AnimationController animationController;
  final Widget child;
  const BottomMoveTopAnimation(
      {super.key, required this.animationController, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        child: child,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animationController,
            child: Transform(
              // it
              transform: Matrix4.translationValues(
                  0.0,
                  40 * (1.0 - animationController.value),
                  0.0),
              child: child,
            ),
          );
        });
  }
}
