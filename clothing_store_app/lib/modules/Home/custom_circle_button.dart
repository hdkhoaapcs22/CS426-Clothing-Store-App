import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/tap_effect.dart';

class CustomCircleButton extends StatelessWidget {
  final String imagePath;
  final String title;

  const CustomCircleButton({
    super.key,
    required this.imagePath,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TapEffect(
          onClick: () {},
          child: CircleAvatar(
            backgroundColor: AppTheme.beigeBackgroundColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image(
                image: AssetImage(imagePath),
                color: AppTheme.brownButtonColor,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          title,
          style: TextStyles(context)
              .getDescriptionStyle()
              .copyWith(color: AppTheme.primaryTextColor, fontSize: 14),
        )
      ],
    );
  }
}
