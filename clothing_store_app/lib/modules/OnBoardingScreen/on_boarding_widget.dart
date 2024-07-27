import 'package:clothing_store_app/modules/OnBoardingScreen/custom_curved_edges.dart';
import 'package:flutter/material.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.imagePath,
    required this.header,
    required this.bodyText,
    required this.page,
    required this.controller,
  });

  final String imagePath;
  final TextSpan header;
  final String bodyText;
  final PageController controller;
  final int page;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(size.height/3.5),
                    decoration: BoxDecoration(
                      color: AppTheme.greyBackgroundColor,
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.fitHeight)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Center(child: RichText(text: header, textAlign: TextAlign.center,)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text(bodyText, style: TextStyles(context).getInterDescriptionStyle(false, false), textAlign: TextAlign.center)),
            ),
          ],
        ),
      )
    );
  }
}