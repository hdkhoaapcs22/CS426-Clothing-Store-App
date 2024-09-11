import 'package:clothing_store_app/class/cloth_item.dart';
import 'package:clothing_store_app/modules/ProductDetails/product_details_screen.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../services/database/cloth_database.dart';
import '../../services/database/favorite_cloth.dart';
import '../../utils/text_styles.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  final String image;
  final double price;
  late bool isFavorite;
  final ClothBase cloth;

  ProductCard(
      {super.key,
      required this.image,
      required this.price,
      required this.cloth,
      this.isFavorite = false});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TapEffect(
      onClick: () async {
        ClothService clothService = ClothService();
        List<ClothItem> allItems =
            await clothService.getClothItems(id: widget.cloth.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                      clothBase: widget.cloth,
                      isFavorite: widget.isFavorite,
                      clothes: allItems,
                    )));
      },
      child: Container(
        width: size.width / 2 - 40,
        height: size.width / 2,
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
                          widget.isFavorite = !widget.isFavorite;
                          FavoriteClothService favoriteList =
                              FavoriteClothService();
                          if (widget.isFavorite) {
                            favoriteList.addFavoriteCloth(
                                clothItemID: widget.cloth.id);
                          } else {
                            favoriteList.removeFavoriteCloth(
                                clothItemID: widget.cloth.id);
                          }
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(200, 247, 238, 211),
                        child: Icon(
                            widget.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                            color: AppTheme.brownButtonColor,
                            size: 20),
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
                          widget.cloth.review.toStringAsFixed(1),
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
