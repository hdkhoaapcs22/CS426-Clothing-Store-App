import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  final AnimationController animationController;

  const ShoppingScreen({super.key, required this.animationController});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
