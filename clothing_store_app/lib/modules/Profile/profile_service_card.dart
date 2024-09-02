import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class ProfileServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onClick;
  final bool isLastService;

  const ProfileServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onClick,
    required this.isLastService
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TapEffect(
      onClick: () {
        onClick!();
      },
      child: SizedBox(
        height: size.height/15,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: AppTheme.brownColor,),
                      const SizedBox(width: 8.0,),
                      Text(
                        AppLocalizations(context).of(title),
                        style: TextStyles(context).getLabelLargeStyle(false).copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  Icon(Iconsax.arrow_right_3, color: AppTheme.brownColor,),
                ],
              ),
            ),
            const SizedBox(height: 8.0,),
            isLastService ? const SizedBox() : Divider(
              indent: 16,
              endIndent: 16,
              thickness: 0.5,
              color: AppTheme.secondaryTextColor.withAlpha(100),
            )
          ],
        ),
      ),
    );
  }
}