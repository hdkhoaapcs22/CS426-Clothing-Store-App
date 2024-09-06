import 'package:flutter/material.dart';

import '../utils/text_styles.dart';
import 'tap_effect.dart';

class CommonDetailedAppBarView extends StatelessWidget {
  final double? topPadding;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final String title;
  final VoidCallback? onSuffixIconClick;
  final VoidCallback? onPrefixIconClick;
  final Color? iconColor;
  final Color backgroundColor;
  final int iconSize;
  final double titleSize;
  const CommonDetailedAppBarView({
    super.key,
    this.topPadding,
    required this.title,
    this.prefixIconData,
    this.suffixIconData,
    this.onPrefixIconClick,
    this.onSuffixIconClick,
    this.iconColor,
    this.iconSize = 25,
    this.backgroundColor = Colors.white,
    this.titleSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final double tmp = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: tmp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                prefixIconData != null ? AppBarButton(
                    onClick: onPrefixIconClick,
                    backgroundColor: backgroundColor,
                    iconData: prefixIconData!,
                    iconColor: Colors.black,
                    iconSize: iconSize) : const SizedBox(width: 65),
                Text(title, style: TextStyles(context).getTitleStyle()),
                suffixIconData != null
                    ? AppBarButton(
                        onClick: onSuffixIconClick,
                        backgroundColor: backgroundColor,
                        iconData: suffixIconData!,
                        iconColor: iconColor,
                        iconSize: iconSize)
                    : const SizedBox(width: 65),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.onClick,
    required this.backgroundColor,
    required this.iconData,
    required this.iconColor,
    required this.iconSize,
  });

  final VoidCallback? onClick;
  final Color backgroundColor;
  final IconData iconData;
  final Color? iconColor;
  final int iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TapEffect(
        onClick: () {
          onClick!();
        },
        child: Container(
          height: 40,
          width: 40,
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
            child: Icon(iconData, color: iconColor, size: iconSize.toDouble()),
          ),
        ),
      ),
    );
  }
}
