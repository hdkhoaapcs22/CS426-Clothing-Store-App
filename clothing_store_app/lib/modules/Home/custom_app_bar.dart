import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/text_styles.dart';
import '../../widgets/tap_effect.dart';

class CustomAppBar extends StatelessWidget {
  final double? topPadding;

  const CustomAppBar({super.key, this.topPadding});

  @override
  Widget build(BuildContext context) {
    final double tmp = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
        padding: EdgeInsets.only(top: tmp),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations(context).of("location"),
                    style: TextStyles(context)
                        .getLabelLargeStyle(true)
                        .copyWith(fontSize: 11),
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location5,
                        size: 20,
                        color: AppTheme.brownColor,
                      ),
                      const SizedBox(width: 5,),
                      Text(
                        'Please select a location',
                        style: TextStyles(context)
                            .getLabelLargeStyle(false)
                            .copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
              TapEffect(
                onClick: () {},
                child: CircleAvatar(
                  backgroundColor: AppTheme.greyBackgroundColor,
                  child: Badge(
                    label: const Text('4'),
                    child: Icon(
                      Iconsax.notification,
                      color: AppTheme.primaryTextColor,  
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
