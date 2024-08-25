import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';

class CustomAddAddressButton extends StatelessWidget {
  final VoidCallback onTap;

  CustomAddAddressButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onTap: onTap,
      radius: 30.0,
      backgroundColor: AppTheme.brownButtonColor,
      buttonTextWidget: Text(
        AppLocalizations(context).of("add_new_shipping_address"),
        style: TextStyles(context).getButtonTextStyle(),
      ),
    );
  }
}
