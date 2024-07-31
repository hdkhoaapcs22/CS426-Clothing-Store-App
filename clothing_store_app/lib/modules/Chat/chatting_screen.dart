import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  final AnimationController animationController;

  const ChattingScreen({super.key, required this.animationController});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
