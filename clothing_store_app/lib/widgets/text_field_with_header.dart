import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../utils/text_styles.dart';

class TextFieldWithHeader extends StatelessWidget {
  const TextFieldWithHeader({
    super.key,
    required this.controller,
    required this.errorMessage,
    required this.header,
    required this.hintText,
    required this.isPassword,
  });

  final TextEditingController controller;
  final String errorMessage;
  final String header;
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(header, style: TextStyles(context).getLabelLargeStyle(false),),
        ),
        CommonTextField(
          isObscureText: isPassword,
          textFieldPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          textEditingController: controller,
          contentPadding: const EdgeInsets.all(16.0),
          hintTextStyle: TextStyles(context).getLabelLargeStyle(true),
          hintText: hintText,
          focusColor: Colors.brown,
          errorText: errorMessage,
          suffixIconData: isPassword? Iconsax.eye_slash : null,
          selectedIconData: isPassword? Iconsax.eye : null,
        ),
      ],
    );
  }
}