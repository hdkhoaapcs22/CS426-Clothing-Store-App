import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  bool isReadOnly;
  final void Function(String)? onFieldSubmitted;

  ChatTextFormField({
    super.key,
    this.focusNode,
    this.controller,
    this.isReadOnly = false,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      autocorrect: false,
      cursorColor: const Color.fromARGB(255, 112, 79, 56),
      focusNode: focusNode,
      controller: controller,
      readOnly: isReadOnly,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: AppLocalizations(context).of("enter_your_prompt"),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(
              color: Colors.grey,
            )),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 112, 79, 56),
            )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter some prompt";
        }
        return null;
      },
    );
  }
}
