import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../utils/text_styles.dart';

class ContinueToPaymentButton extends StatelessWidget {
  final VoidCallback onPressed;

  ContinueToPaymentButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onTap: onPressed,
      radius: 30.0,
      backgroundColor: Colors.brown,
      buttonTextWidget: Text(
        AppLocalizations(context).of('continue_to_payment'),
        style: TextStyles(context).getButtonTextStyle(),
      ),
    );
  }
}
