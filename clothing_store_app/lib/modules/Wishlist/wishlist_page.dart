import 'package:clothing_store_app/class/cloth_item.dart';
import 'package:clothing_store_app/global/global_var.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/Home/common_product_widget.dart';
import 'package:clothing_store_app/providers/wishlist_provider.dart';
import 'package:clothing_store_app/services/database/favorite_cloth.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/bottom_move_top_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WishlistPage extends StatefulWidget {
  AnimationController animationController;
  WishlistPage({super.key, required this.animationController});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    List<String> categories = ['All', 'Jacket', 'Pants', 'Shirt', 'T-shirt'];
    final size = MediaQuery.of(context).size;

    return Consumer<WishlistProvider>(builder: (context, wishlistProvider, _) {
      return StreamBuilder(
          stream: FavoriteClothService().getFavoriteClothStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Lottie.asset(
                    Localfiles.loading,
                    width: lottieSize,
                  ));
            }

            int chosenIndex = wishlistProvider.chosenIndex;
            List<DocumentSnapshot<Object?>> dc = snapshot.data!.docs;
            List<String> favoriteIds = dc.map((doc) => doc.id).toList();
            Map<String, ClothBase> resClothes = filterClothesByFavorite(
                GlobalVar.listAllCloth,
                favids: favoriteIds);

            if (chosenIndex == 0) {
              resClothes = filterClothesByFavorite(GlobalVar.listAllCloth,
                  favids: favoriteIds);
            } else if (chosenIndex == 1) {
              resClothes = filterClothesByFavoriteAndType(
                  GlobalVar.listAllCloth,
                  favids: favoriteIds,
                  clothtype: 'jacket');
            } else if (chosenIndex == 2) {
              resClothes = filterClothesByFavoriteAndType(
                  GlobalVar.listAllCloth,
                  favids: favoriteIds,
                  clothtype: 'pant');
            } else if (chosenIndex == 3) {
              resClothes = filterClothesByFavoriteAndType(
                  GlobalVar.listAllCloth,
                  favids: favoriteIds,
                  clothtype: 'shirt');
            } else if (chosenIndex == 4) {
              resClothes = filterClothesByFavoriteAndType(
                  GlobalVar.listAllCloth,
                  favids: favoriteIds,
                  clothtype: 'tshirt');
            }

            return BottomMoveTopAnimation(
              animationController: widget.animationController,
              child: Scaffold(
                backgroundColor: AppTheme.scaffoldBackgroundColor,
                body: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                              AppLocalizations(context).of("wishlist_title"),
                              style: TextStyles(context).getTitleStyle()),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.055,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      wishlistProvider.update(index);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: chosenIndex == index
                                            ? const Color.fromRGBO(
                                                88, 57, 39, 1)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    child: Text(categories[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: chosenIndex == index
                                                ? Colors.white
                                                : const Color.fromRGBO(
                                                    88, 57, 39, 1))),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(16)),
                        SizedBox(
                            height: size.height * 0.7,
                            child: buildProductGrid(
                                resClothes, size, favoriteIds)),
                      ],
                    )),
              ),
            );
          });
    });
  }

  Widget buildProductGrid(
      Map<String, ClothBase> clothes, Size size, List<String> favoriteList) {
    return GridView.builder(
        itemCount: clothes.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          mainAxisExtent: size.width / 2 + 10,
        ),
        itemBuilder: (context, index) {
          final clothKey = clothes.keys.elementAt(index);
          final clothBase = clothes[clothKey]!;
          final isFavorite = favoriteList.contains(clothBase.id);
          return FutureBuilder<List<ClothItem>>(
              future: clothBase.clothItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Loading'));
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading product'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found'));
                } else {
                  final clothItem = snapshot.data!.first;
                  return ProductCard(
                    image: clothItem.clothImageURL,
                    price: clothItem.price,
                    cloth: clothBase,
                    isFavorite: isFavorite,
                  );
                }
              });
        });
  }

  Map<String, ClothBase> filterClothesByFavorite(
    Map<String, ClothBase> clothes, {
    required List<String> favids,
  }) {
    return Map.fromEntries(
      clothes.entries.where((entry) => favids.contains(entry.value.id)),
    );
  }

  Map<String, ClothBase> filterClothesByFavoriteAndType(
    Map<String, ClothBase> clothes, {
    required List<String> favids,
    required String clothtype,
  }) {
    return Map.fromEntries(
      clothes.entries.where((entry) =>
          (favids.contains(entry.value.id) && entry.value.type == clothtype)),
    );
  }
}
