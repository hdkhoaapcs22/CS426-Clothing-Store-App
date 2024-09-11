import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../widgets/common_button.dart';

class BannerContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const BannerContent(
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
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              left: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles(context)
                        .getHeaderStyle(false)
                        .copyWith(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    description,
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                        fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  CommonButton(
                    buttonTextWidget: Text(
                      AppLocalizations(context).of("shop_now"),
                      style: TextStyles(context)
                          .getButtonTextStyle()
                          .copyWith(fontSize: 12),
                    ),
                    radius: 10,
                    width: size.width / 4 + 6,
                    height: size.height / 25,
                    backgroundColor: const Color.fromARGB(255, 112, 79, 56),
                    onTap: () {},
                  )
                ],
              ))
        ],
      ),
    );
  }
}
