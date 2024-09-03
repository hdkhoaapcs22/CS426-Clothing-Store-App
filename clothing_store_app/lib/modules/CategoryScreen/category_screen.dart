import 'package:clothing_store_app/global/global_var.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../class/cloth_item.dart';
import '../../languages/appLocalizations.dart';
import '../../services/database/favorite_cloth.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_detailed_app_bar.dart';
import '../Home/common_product_widget.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  String categoryType;
  CategoryScreen({super.key, required this.categoryType});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
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
          List<DocumentSnapshot<Object?>> dc = snapshot.data!.docs;
          List<String> favoriteIds = dc.map((doc) => doc.id).toList();
          return Scaffold(
            body: SingleChildScrollView(
                child: Column(
              children: [
                CommonDetailedAppBarView(
                  //App Bar
                  title: AppLocalizations(context).of(widget.categoryType),
                  prefixIconData: Iconsax.arrow_left,
                  onPrefixIconClick: () {
                    Navigator.pop(context);
                  },
                  iconColor: AppTheme.primaryTextColor,
                  backgroundColor: AppTheme.backgroundColor,
                ),
                const SizedBox(height: 16.0,),
                _buildProductGrid(_filterClothesByType(GlobalVar.listAllCloth, type: widget.categoryType), size, favoriteIds)
              ],
            )),
          ); 
      }
    );
  }
}

Widget _buildProductGrid(Map<String, ClothBase> clothes, Size size, List<String> favoriteList) {
  return GridView.builder(
      itemCount: clothes.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        mainAxisExtent: size.height / 4 + 10,
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

Map<String, ClothBase> _filterClothesByType(
    Map<String, ClothBase> clothes, {
      required String type,
    }) {
  return Map.fromEntries(
    clothes.entries.where((entry) => entry.value.type == type),
  );
}