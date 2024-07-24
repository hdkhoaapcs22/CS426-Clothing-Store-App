import 'package:flutter/material.dart';
import '../languages/appLocalizations.dart';
import '../utils/text_styles.dart';
import 'tap_effect.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? buttonText;
  final Widget? buttonTextWidget;
  final Color? textColor, backgroundColor;
  bool isClickable;
  final double radius;
  double height, width, fontSize;
  bool isVisibility;

  CommonButton({
    super.key,
    this.onTap,
    this.padding,
    this.buttonText,
    this.buttonTextWidget,
    this.textColor = Colors.white,
    this.backgroundColor = const Color.fromRGBO(88, 57, 39, 1),
    this.isClickable = true,
    this.radius = 20.0,
    this.height = 57,
    this.fontSize = 18,
    this.width = double.infinity,
    this.isVisibility = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(),
      child: TapEffect(
        isClickable: isClickable,
        onClick: onTap ?? () {},
        child: SizedBox(
          height: height,
          width: width,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              color: backgroundColor ?? Theme.of(context).primaryColor,
              shadowColor: Colors.black12.withOpacity(
                  Theme.of(context).brightness == Brightness.light ? 0.6 : 0.2),
              child: isVisibility
                  ? Center(
                      child: buttonTextWidget ??
                          Text(
                            buttonText != null
                                ? AppLocalizations(context).of(buttonText!)
                                : "",
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      color: textColor,
                                      fontSize: fontSize,
                                    ),
                          ),
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }
}
