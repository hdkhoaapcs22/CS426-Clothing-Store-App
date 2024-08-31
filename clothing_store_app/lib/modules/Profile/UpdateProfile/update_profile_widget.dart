import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';
import '../../../widgets/tap_effect.dart';

class UpdateProfileWidget extends StatelessWidget {
  const UpdateProfileWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onClick
  });

  final String title;
  final String content;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles(context).getLabelLargeStyle(false).copyWith(fontSize: 14, color: AppTheme.brownButtonColor),),
          const SizedBox(height: 3.0,),
          TapEffect(
            onClick: () {
              onClick!();
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: AppTheme.brownButtonColor),
                color: AppTheme.backgroundColor
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(content, style: TextStyles(context).getDescriptionStyle().copyWith(fontStyle: FontStyle.italic),),
                ))
            ),
          ),
        ],
      ),
    );
  }
}