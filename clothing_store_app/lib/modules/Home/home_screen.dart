import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/bottom_move_top_animation.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeScreen({super.key, required this.animationController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BottomMoveTopAnimation(
        animationController: widget.animationController,
        child: Center(
          child: TextButton(
            child: Text('Home Screen'),
            onPressed: () {},
          ),
        ));
  }
}
