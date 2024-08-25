import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class ApplyButton extends StatelessWidget {
  final VoidCallback onPressed;

  ApplyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onTap: onPressed,
      radius: 30.0,
      backgroundColor: AppTheme.brownButtonColor,
      buttonTextWidget: Text(
        AppLocalizations(context).of("apply"),
        style: TextStyles(context).getButtonTextStyle(),
      ),
    );
  }
}
