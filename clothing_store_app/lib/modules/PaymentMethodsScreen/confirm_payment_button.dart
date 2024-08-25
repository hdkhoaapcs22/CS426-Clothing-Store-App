import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../widgets/common_button.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class ConfirmPaymentButton extends StatelessWidget {
  final VoidCallback onPressed;

  ConfirmPaymentButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onTap: onPressed,
      radius: 30.0,
      backgroundColor: AppTheme.brownButtonColor,
      buttonTextWidget: Text(
        AppLocalizations(context).of("confirm_payment"),
        style: TextStyles(context).getButtonTextStyle(),
      ),
    );
  }
}
