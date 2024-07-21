import 'package:flutter/material.dart';

class TapEffect extends StatefulWidget {
  final bool isClickable;
  final VoidCallback onClick;
  final Widget child;

  const TapEffect(
      {Key? key,
      this.isClickable = true,
      required this.onClick,
      required this.child})
      : super(key: key);

  @override
  State<TapEffect> createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  DateTime tapTime = DateTime.now();
  bool isProcess = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animationController!.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  dispose() {
    animationController!.dispose();
    super.dispose();
  }

  Future<void> onTapCancel() async {
    if (widget.isClickable) {
      await _onDelayed();
      animationController!.animateTo(1.0,
          duration: const Duration(milliseconds: 240),
          curve: Curves.fastOutSlowIn);
    }
    isProcess = false;
  }

  Future<void> _onDelayed() async {
    if (widget.isClickable) {
      // this loic creator like more process experience with some delay
      final int tapDuration = DateTime.now().millisecondsSinceEpoch -
          tapTime.millisecondsSinceEpoch;
      if (tapDuration < 120) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 280));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (widget.isClickable) {
            await Future<dynamic>.delayed(const Duration(milliseconds: 280));
            try {
              if (!isProcess) {
                widget.onClick();
                isProcess = true;
              }
            } catch (_) {}
          }
        },
        onTapDown: (TapDownDetails details) {
          if (widget.isClickable) {
            tapTime = DateTime.now();
            animationController!.animateTo(0.9,
                duration: const Duration(milliseconds: 120),
                curve: Curves.fastOutSlowIn);
          }
          isProcess = true;
        },
        onTapUp: (TapUpDetails details) {
          onTapCancel();
        },
        onTapCancel: () {
          onTapCancel();
        },
        child: AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: animationController!.value,
              origin: const Offset(0.0, 0.0),
              child: widget.child,
            );
          },
        ));
  }
}
