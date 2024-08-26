import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/OnBoardingScreen/custom_curved_edges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/themes.dart';
import '../../widgets/common_detailed_app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonDetailedAppBarView(
                title: AppLocalizations(context).of("product_details_title"),
                prefixIconData: Iconsax.arrow_left,
                suffixIconData: Iconsax.heart,
                onPrefixIconClick: () {
                  //go back
                },
                onSuffixIconClick: () {
                  //go to
                },
              ),
              ClipPath(
                clipper: CustomCurvedEdges(),
                child: Stack(
                  children: [
                    Container(
                      height: size.height / 1.3,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.8), // Adjust shadow color and opacity
                            offset: Offset(0, -5), // Shadow position
                            blurRadius: 10, // Shadow blur
                            spreadRadius: 5, // Shadow spread
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
