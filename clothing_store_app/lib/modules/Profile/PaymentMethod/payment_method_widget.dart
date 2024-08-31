import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';
import '../../../widgets/tap_effect.dart';

// ignore: must_be_immutable
class PaymentMethodWidget extends StatelessWidget {
  final String content;
  IconData? icon;
  String? image;
  BorderRadiusGeometry? borderRadius;
  final VoidCallback? onClick;

  PaymentMethodWidget({
    super.key,
    required this.content,
    this.icon,
    this.image,
    this.borderRadius,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: () {
        onClick!();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            border:
                Border.all(color: AppTheme.greyBackgroundColor),
            borderRadius: borderRadius ?? BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon != null ? Icon(
                    icon,
                    color: AppTheme.brownButtonColor,
                  ) : CircleAvatar(
                    radius: 10,
                    backgroundColor: AppTheme.backgroundColor,
                    child: Image(image: AssetImage(image!), fit: BoxFit.fill,),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    content,
                    style: TextStyles(context)
                        .getDescriptionStyle()
                        .copyWith(
                            color: AppTheme.primaryTextColor,
                            fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text(
                'Link',
                style: TextStyles(context)
                    .getDescriptionStyle()
                    .copyWith(color: AppTheme.brownButtonColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}