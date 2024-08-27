import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/OnBoardingScreen/custom_curved_edges.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
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
              // ClipPath(
              //   clipper: CustomCurvedEdges(),
              //   child: Stack(
              //     children: [
              //       Container(
              //         height: size.height / 1.3,
              //         decoration: BoxDecoration(
              //           color: AppTheme.backgroundColor,
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(
              //                   0.8),
              //               offset: const Offset(0, -5),
              //               blurRadius: 10,
              //               spreadRadius: 5,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Row(
              //   children: [
              //     CommonButton(buttonText: 'add_to_cart',),
              //   ],
              // )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: size.height / 11,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Price', style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14),),
                    Text('\$83.97', style: TextStyles(context).getDescriptionStyle().copyWith(fontWeight: FontWeight.w500, color: AppTheme.primaryTextColor),)
                  ],
                ),
                const SizedBox(width: 16.0,),
                Expanded(child: CommonButton(
                  buttonText: 'add_to_cart',
                  icon: Iconsax.shopping_bag5,
                  radius: 40,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
