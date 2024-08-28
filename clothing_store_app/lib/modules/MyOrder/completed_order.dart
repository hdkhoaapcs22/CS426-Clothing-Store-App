import 'package:flutter/material.dart';

import '../../widgets/bottom_move_top_animation.dart';

class CompletedOrder extends StatefulWidget {
  final AnimationController animationController;
  const CompletedOrder({super.key, required this.animationController});

  @override
  State<CompletedOrder> createState() => _CompletedOrderState();
}

class _CompletedOrderState extends State<CompletedOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BottomMoveTopAnimation(
        animationController: widget.animationController,
        child: Center(
          child: TextButton(
            child: Text('My Order'),
            onPressed: () {},
          ),
        ));
  }
}
