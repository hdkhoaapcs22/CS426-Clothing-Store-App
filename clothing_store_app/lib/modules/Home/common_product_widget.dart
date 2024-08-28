import 'package:clothing_store_app/class/cloth_item.dart';
import 'package:clothing_store_app/modules/ProductDetails/product_details_screen.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../services/database/cloth_database.dart';
import '../../utils/text_styles.dart';

class ProductCard extends StatefulWidget {
  final String image;
  final double productReviews;
  final double price;
  final bool isFavorite;
  final ClothBase cloth;

  const ProductCard({
    super.key,
    required this.image,
    required this.productReviews,
    required this.price,
    required this.cloth,
    this.isFavorite = false
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TapEffect(
      onClick: () async {
        ClothService clothService = ClothService(FirebaseFirestore.instance.collection('Cloth'));
        List<ClothItem> allItems = await clothService.getClothItems(id: widget.cloth.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => 
        ProductDetailsScreen(
                      isFavorite: isFavorite,
                      productName: widget.cloth.name,
                      productDescription: widget.cloth.description,
                      gender: widget.cloth.gender,
                      clothes: allItems,
                    )));
      },
      child: Container(
        width: size.width / 2 - 40,
        height: size.height / 4,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: size.width / 2,
                    height: size.width / 2 - 40,
                    child: Image(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child: TapEffect(
                      onClick: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(200, 247, 238, 211),
                        child: Icon(isFavorite ? Iconsax.heart5 : Iconsax.heart,
                            color: AppTheme.brownButtonColor, size: 20),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.cloth.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles(context).getLabelLargeStyle(false),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.star1,
                          color: AppTheme.yellowColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.productReviews.toStringAsFixed(1),
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
                Text('\$ ${widget.price.toStringAsFixed(2)}')
              ],
            )
          ],
        ),
      ),
    );
  }
}
