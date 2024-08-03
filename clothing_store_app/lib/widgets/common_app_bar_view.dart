import 'package:flutter/material.dart';

import 'tap_effect.dart';

class CommonAppBarView extends StatelessWidget {
  final double? topPadding;
  final IconData iconData;
  final VoidCallback? onBackClick;
  final Color? iconColor;
  final Color backgroundColor;
  final int iconSize;
  const CommonAppBarView({
    super.key,
    this.topPadding,
    required this.iconData,
    this.onBackClick,
    this.iconColor,
    this.iconSize = 30,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final double tmp = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: tmp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TapEffect(
                onClick: () {
                  onBackClick!();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(2.0, 3.5),
                          blurRadius: 8),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      iconData,
                      color: iconColor,
                      size: iconSize.toDouble()
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0,)
        ],
      ),
    );
  }
}
