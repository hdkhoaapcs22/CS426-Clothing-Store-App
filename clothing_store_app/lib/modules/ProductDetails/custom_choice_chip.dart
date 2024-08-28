import 'package:clothing_store_app/common/helper_funtion.dart';
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function(bool)? onSelected;

  const CustomChoiceChip({
    super.key,
    required this.text,
    required this.isSelected,
    this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    final bool isColor = HelperFunction.getColor(text) != null;
    return ChoiceChip(
      label: isColor ? const SizedBox() : const Text(''),
      selected: isSelected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: isSelected? Colors.white : null),
      avatar: isColor ? CircleAvatar(backgroundColor: HelperFunction.getColor(text), radius: 20,) : null,
      shape: const CircleBorder(),
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      checkmarkColor: Colors.white,
      selectedColor: HelperFunction.getColor(text),
      backgroundColor: HelperFunction.getColor(text),
    );
  }
}