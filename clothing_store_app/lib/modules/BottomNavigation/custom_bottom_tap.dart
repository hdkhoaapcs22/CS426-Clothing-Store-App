import 'package:flutter/material.dart';

import '../../../utils/themes.dart';

class TabButtonUI extends StatelessWidget {
  final IconData icon;
  final IconData iconSelected;
  final bool isSelected;
  final Function()? onTap;
  const TabButtonUI({
    super.key,
    required this.icon,
    required this.iconSelected,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: Icon(
              isSelected ? iconSelected : icon,
              color: isSelected
                  ? AppTheme.brownButtonColor
                  : AppTheme.secondaryTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
