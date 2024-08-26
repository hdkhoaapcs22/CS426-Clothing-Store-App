import 'package:flutter/material.dart';
import 'package:clothing_store_app/utils/text_styles.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final String selectedCategory;
  final VoidCallback onPressed;

  CategoryButton({
    required this.category,
    required this.selectedCategory,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedCategory == category ? Colors.brown : Colors.grey,
      ),
      child: Text(
        category,
        style: TextStyles(context)
            .getCategoryButtonStyle(selectedCategory == category),
      ),
    );
  }
}
