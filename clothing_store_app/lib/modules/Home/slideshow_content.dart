import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';

class SlideShowContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const SlideShowContent(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              width: double.infinity,
              height: size.height / 5.2,
              child: Image(
                image: AssetImage(imagePath),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
              left: 10,
              bottom: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles(context)
                        .getHeaderStyle(false)
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                        fontSize: 12, color: AppTheme.primaryTextColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonButton(
                    buttonTextWidget: Text(
                      AppLocalizations(context).of("shop_now"),
                      style: TextStyles(context)
                          .getButtonTextStyle()
                          .copyWith(fontSize: 12),
                    ),
                    radius: 10,
                    width: size.width / 4,
                    height: size.height / 25,
                    backgroundColor: AppTheme.brownButtonColor,
                    onTap: () {},
                  )
                ],
              ))
        ],
      ),
    );
  }
}
