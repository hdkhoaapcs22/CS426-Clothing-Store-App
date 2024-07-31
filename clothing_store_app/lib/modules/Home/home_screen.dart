import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeScreen({super.key, required this.animationController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
