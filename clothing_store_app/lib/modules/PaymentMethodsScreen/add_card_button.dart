import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';

class AddCardButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddCardButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onTap: onPressed,
      radius: 30.0,
      backgroundColor: AppTheme.brownButtonColor,
      buttonTextWidget: Text(
        AppLocalizations(context).of("add_card"),
        style: TextStyles(context).getButtonTextStyle(),
      ),
    );
    ;
  }
}
