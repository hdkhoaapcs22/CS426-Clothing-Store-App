import 'package:clothing_store_app/common/colors.dart';
import 'package:clothing_store_app/modules/OnBoardingScreen/custom_curved_edges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingWidget extends StatelessWidget {
  OnBoardingWidget({
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

  final TextStyle _bodyStyle = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: greyText,
  );

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.all(250),
                    decoration: BoxDecoration(
                      color: greyBackground,
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.fitHeight)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: RichText(text: header, textAlign: TextAlign.center,)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text(bodyText, style: _bodyStyle, textAlign: TextAlign.center)),
            ),
          ],
        ),
      )
    );
  }
}