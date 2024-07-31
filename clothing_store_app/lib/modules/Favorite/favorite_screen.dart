import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  final AnimationController animationController;

  const FavoriteScreen({super.key, required this.animationController});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
