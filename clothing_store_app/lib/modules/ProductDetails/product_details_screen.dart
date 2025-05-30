import 'package:clothing_store_app/common/helper_funtion.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/ProductDetails/custom_choice_chip.dart';
import 'package:clothing_store_app/modules/ProductDetails/custom_diagonal_line.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/services/database/cart.dart';
import 'package:clothing_store_app/services/database/favorite_cloth.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../class/cloth_item.dart';
import '../../utils/themes.dart';
import '../../widgets/common_detailed_app_bar.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  late bool isFavorite;
  final ClothBase clothBase;
  final List<ClothItem> clothes;

  ProductDetailsScreen(
      {super.key,
      required this.isFavorite,
      required this.clothBase,
      required this.clothes});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedID = 0;
  int selectedSize = -1;
  int selectedColor = 0;
  late List<String> allSizes;

  String getGender(String key) {
    switch (key) {
      case 'M':
        return 'Man';
      case 'F':
        return 'Woman';
      default:
        return 'Man';
    }
  }

  void _getAllSizes() {
    allSizes = widget.clothes[selectedColor].sizeWithQuantity.keys.toList();
    allSizes = HelperFunction.sortListOfSizes(allSizes);
  }

  @override
  void initState() {
    _getAllSizes();
    super.initState();
  }

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
                      child: Image(
                    image:
                        NetworkImage(widget.clothes[selectedID].clothImageURL),
                  )),
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
                                    selectedColor = selectedID;
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          width: 3,
                                          color: selectedID == index
                                              ? AppTheme.backgroundColor
                                              : Colors.transparent)),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image(
                                        image: NetworkImage(widget
                                            .clothes[index].clothImageURL)),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                            itemCount: widget.clothes.length),
                      ),
                    ),
                  ),
                ),
                CommonDetailedAppBarView(
                  title: AppLocalizations(context).of("product_details_title"),
                  prefixIconData: Iconsax.arrow_left,
                  suffixIconData:
                      widget.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                  iconColor: AppTheme.brownButtonColor,
                  onPrefixIconClick: () {
                    Navigator.pop(context);
                  },
                  onSuffixIconClick: () {
                    setState(() {
                      widget.isFavorite = !widget.isFavorite;
                      FavoriteClothService favoriteList =
                          FavoriteClothService();
                      if (widget.isFavorite) {
                        favoriteList.addFavoriteCloth(
                            clothItemID: widget.clothBase.id);
                      } else {
                        favoriteList.removeFavoriteCloth(
                            clothItemID: widget.clothBase.id);
                      }
                    });
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
                          '${getGender(widget.clothBase.gender)}\'s Style',
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
                            widget.clothBase.review.toStringAsFixed(1),
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  //------------------  Name of product ----------------------
                  Text(
                    widget.clothBase.name,
                    style: TextStyles(context).getLargerHeaderStyle(false),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  //------------------  Product Details ----------------------
                  Text(
                    'Product Details',
                    style: TextStyles(context)
                        .getLabelLargeStyle(false)
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ReadMoreText(
                    widget.clothBase.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: '\tLess',
                    moreStyle: TextStyles(context)
                        .getInterDescriptionStyle(false, false)
                        .copyWith(fontSize: 14),
                    lessStyle: TextStyles(context)
                        .getInterDescriptionStyle(false, false)
                        .copyWith(fontSize: 14),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: AppTheme.secondaryTextColor,
                  ),
                  //------------------  Select Size ----------------------
                  Text('Select Size',
                      style: TextStyles(context)
                          .getLabelLargeStyle(false)
                          .copyWith(fontSize: 16)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          bool isOutOfStock = widget.clothes[selectedColor]
                                  .sizeWithQuantity[allSizes[index]] ==
                              0;
                          return TapEffect(
                            onClick: () {
                              if (!isOutOfStock) {
                                setState(() {
                                  selectedSize = index;
                                });
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                    height: 50,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: selectedSize == index
                                          ? AppTheme.brownButtonColor
                                          : AppTheme.backgroundColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      allSizes[index],
                                      style: TextStyles(context)
                                          .getButtonTextStyle()
                                          .copyWith(
                                              color: isOutOfStock
                                                  ? Colors.grey
                                                  : selectedSize == index
                                                      ? AppTheme.backgroundColor
                                                      : AppTheme
                                                          .primaryTextColor,
                                              fontSize: 16),
                                    ))),
                                if (isOutOfStock)
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: CustomDiagonalLine(),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              width: 8.0,
                            ),
                        itemCount: widget
                            .clothes[selectedColor].sizeWithQuantity.length),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  //------------------  Select Color ----------------------
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Select Color: \t',
                        style: TextStyles(context)
                            .getLabelLargeStyle(false)
                            .copyWith(fontSize: 16)),
                    TextSpan(
                        text: widget.clothes[selectedColor].color,
                        style: TextStyles(context).getDescriptionStyle())
                  ])),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return TapEffect(
                            onClick: () {},
                            child: CustomChoiceChip(
                              text: widget.clothes[index].color,
                              isSelected: selectedColor == index,
                              onSelected: (value) {
                                setState(() {
                                  selectedColor = index;
                                  _getAllSizes();
                                });
                              },
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              width: 8.0,
                            ),
                        itemCount: widget.clothes.length),
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
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyles(context)
                          .getDescriptionStyle()
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      '\$ ${widget.clothes[selectedColor].price}',
                      style: TextStyles(context).getDescriptionStyle().copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryTextColor),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                  child: CommonButton(
                      onTap: () {
                        CartService().addItemIntoCart(
                            clothItemID: widget.clothBase.id,
                            name: widget.clothBase.name,
                            imageURl:
                                widget.clothes[selectedColor].clothImageURL,
                            size: allSizes[selectedSize],
                            price: widget.clothes[selectedColor].price,
                            orderQuantity: 1,
                            quantity: widget.clothes[selectedColor]
                                .sizeWithQuantity[allSizes[selectedSize]]);
                        NavigationServices(context).gotoCartScreen();
                      },
                      buttonText: 'add_to_cart',
                      icon: Iconsax.shopping_bag5,
                      radius: 40,
                      padding: const EdgeInsets.all(16))),
            ],
          ),
        ),
      ),
    );
  }
}
