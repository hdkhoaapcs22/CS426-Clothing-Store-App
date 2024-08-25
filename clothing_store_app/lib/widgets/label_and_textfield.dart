import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget labelAndTextField(
    {required BuildContext context,
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String errorText,
    IconData? suffixIconData,
    IconData? selectedIconData,
    bool? isObscured}) {
  return SizedBox(
    height: 105,
    child: Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          AppLocalizations(context).of(label),
          style: TextStyles(context).getRegularStyle(),
        ),
      ),
      CommonTextField(
        isObscureText: isObscured ?? false,
        textEditingController: controller,
        contentPadding: const EdgeInsets.all(14),
        hintTextStyle: TextStyles(context).getDescriptionStyle(),
        focusColor: const Color.fromARGB(255, 112, 79, 56),
        hintText: hintText,
        textFieldPadding: const EdgeInsets.only(top: 5, bottom: 2),
        errorText: errorText,
        suffixIconData: suffixIconData,
        selectedIconData: selectedIconData,
      ),
    ]),
  );
}
