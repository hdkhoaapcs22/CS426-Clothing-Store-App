import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/tap_effect.dart';

class CustomCircleButton extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final Color? backgroundColor;
  final double? radius;
  final IconData? icon;
  final VoidCallback? onClick;

  const CustomCircleButton(
      {super.key,
      this.imagePath,
      this.title,
      this.backgroundColor,
      this.radius = 30,
      this.icon,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TapEffect(
          onClick: () {
            onClick!();
          },
          child: CircleAvatar(
            backgroundColor: backgroundColor ?? AppTheme.beigeBackgroundColor,
            radius: radius,
            child: icon!= null ? Center(child: Icon(icon)) : Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image(
                      image: AssetImage(imagePath!),
                      color: AppTheme.brownButtonColor,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
        title != null
            ? Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                  title!,
                  style: TextStyles(context)
                      .getDescriptionStyle()
                      .copyWith(color: AppTheme.primaryTextColor, fontSize: 14),
                ),
            )
            : const SizedBox()
      ],
    );
  }
}
