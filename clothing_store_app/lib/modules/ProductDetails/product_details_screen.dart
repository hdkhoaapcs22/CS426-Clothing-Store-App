import 'package:clothing_store_app/class/cloth_item.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/ProductDetails/custom_choice_chip.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../utils/themes.dart';
import '../../widgets/common_detailed_app_bar.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  late bool isFavorite;
  ProductDetailsScreen({super.key, required this.isFavorite});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedID = 0;
  int selectedSize = 0;
  int selectedColor = 0;

  List<String> allproducts = [
    'assets/images/tshirt1.jpg',
    'assets/images/tshirt1.1.jpg',
    'assets/images/tshirt1.2.jpg',
    'assets/images/tshirt1.4.jpg',
    'assets/images/tshirt1.5.jpg',
    'assets/images/tshirt1.2.jpg',
    'assets/images/tshirt1.4.jpg',
    'assets/images/tshirt1.5.jpg',
  ];

  List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL'
  ];

  List<String> colors = [
    'green',
    'yellow',
    'orange',
    'blue'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child:
                      Image(image: AssetImage(allproducts[selectedID]),),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 80,
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return TapEffect(
                              onClick: () {
                                setState(() {
                                  selectedID = index;
                                });
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    width: 3,
                                    color: selectedID == index ? AppTheme.backgroundColor : Colors.transparent
                                  )
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Image(
                                    image: AssetImage(allproducts[index]),
                                  ),
                                ),
                              ),
                            );
                          }, 
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8.0,), 
                          itemCount: allproducts.length
                        ),
                      ),
                    ),
                  ),
                ),
                CommonDetailedAppBarView(
                  title: AppLocalizations(context).of("product_details_title"),
                  prefixIconData: Iconsax.arrow_left,
                  suffixIconData: widget.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                  onPrefixIconClick: () {
                    Navigator.pop(context);
                  },
                  onSuffixIconClick: () {
                    widget.isFavorite != widget.isFavorite;
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Female\'s Style',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyles(context).getDescriptionStyle(),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.star1,
                            color: AppTheme.yellowColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '4.9',
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8.0,),
                  //------------------  Name of product ----------------------
                  Text('Light T-Shirt',  style: TextStyles(context).getLargerHeaderStyle(false),),
                  const SizedBox(height: 8.0,),
                  //------------------  Product Details ----------------------
                  Text('Product Details',  style: TextStyles(context).getLabelLargeStyle(false).copyWith(fontSize: 16),),
                  const SizedBox(height: 8.0,),
                  ReadMoreText(
                    'The shorts offer a clean and casual look, perfect for warm weather. They feature a straight-leg design with a comfortable fit that pairs well with both casual and sporty outfits. Made from a lightweight material, they provide ease of movement and are ideal for everyday wear.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: '\tLess',
                    moreStyle: TextStyles(context).getInterDescriptionStyle(false, false).copyWith(fontSize: 14),
                    lessStyle: TextStyles(context).getInterDescriptionStyle(false, false).copyWith(fontSize: 14),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: AppTheme.secondaryTextColor,
                  ),
                  //------------------  Select Size ----------------------
                  Text('Select Size', style: TextStyles(context).getLabelLargeStyle(false).copyWith(fontSize: 16)),
                  const SizedBox(height: 8.0,),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return TapEffect(
                            onClick: () {
                              setState(() {
                                selectedSize = index;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 55,
                              decoration: BoxDecoration(
                                color: selectedSize == index
                                      ? AppTheme.brownButtonColor
                                      : AppTheme.backgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text(sizes[index], style: TextStyles(context).getButtonTextStyle().copyWith(color: selectedSize == index ? AppTheme.backgroundColor : AppTheme.primaryTextColor, fontSize: 16),))),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              width: 8.0,
                            ),
                        itemCount: sizes.length),
                  ),
                  const SizedBox(height: 8.0,),
                  //------------------  Select Color ----------------------
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Select Color: \t',
                          style: TextStyles(context).getLabelLargeStyle(false).copyWith(fontSize: 16)
                        ),
                        TextSpan(
                          text: colors[selectedColor],
                          style: TextStyles(context).getDescriptionStyle()
                        )
                      ])
                  ),
                  const SizedBox(height: 8.0,),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return TapEffect(
                            onClick: () {
                              // setState(() {
                              //   selectedColor = index;
                              // });
                            },
                            child: CustomChoiceChip(
                              text: colors[index],
                              isSelected: selectedColor == index,
                              onSelected: (value) {
                                setState(() {
                                  selectedColor = index;
                                });
                              },
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              width: 8.0,
                            ),
                        itemCount: colors.length),
                  ),
                ],
              ),
            )
          ],
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
