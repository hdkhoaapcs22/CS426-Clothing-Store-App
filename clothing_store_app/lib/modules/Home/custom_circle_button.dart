import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/tap_effect.dart';

class CustomCircleButton extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final Color? backgroundColor;
  final IconData? icon;
  final VoidCallback? onClick;

  const CustomCircleButton(
      {super.key,
      this.imagePath,
      this.title,
      this.backgroundColor,
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
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: icon != null
                  ? Icon(icon)
                  : Image(
                      image: AssetImage(imagePath!),
                      color: AppTheme.brownButtonColor,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        title != null
            ? Text(
                title!,
                style: TextStyles(context)
                    .getDescriptionStyle()
                    .copyWith(color: AppTheme.primaryTextColor, fontSize: 14),
              )
            : const SizedBox()
      ],
    );
  }
}
