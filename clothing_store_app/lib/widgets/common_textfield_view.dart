import 'package:flutter/material.dart';

import '../languages/appLocalizations.dart';
import '../utils/text_styles.dart';
import '../utils/themes.dart';

class CommonTextFieldView extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool isObscureText; // used to hide password
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final TextInputType? keyboardType; // used to set keyboard type
  final bool isNextFocusable;

  const CommonTextFieldView({
    super.key,
    this.hintText,
    this.errorText,
    this.isObscureText = false,
    required this.padding,
    this.keyboardType,
    this.controller,
    this.isNextFocusable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            shadowColor: Colors.black12.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.3),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: controller,
                  obscureText: isObscureText,
                  style: TextStyles(context).getRegularStyle(),
                  maxLines: 1,
                  cursorColor: Theme.of(context).primaryColor,
                  onEditingComplete: () {
                    if (isNextFocusable) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations(context).of(hintText!),
                    errorText: null,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  ),
                  keyboardType: keyboardType,
                )),
          ),
          if (errorText != null && errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                errorText ?? "",
                style: TextStyles(context).getDescriptionStyle().copyWith(
                      color: AppTheme.redErrorColor,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
