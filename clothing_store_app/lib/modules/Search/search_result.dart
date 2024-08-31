import 'package:clothing_store_app/class/cloth_item.dart';
import 'package:clothing_store_app/global/global_var.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/Home/common_product_widget.dart';
import 'package:clothing_store_app/providers/filter_provider.dart';
import 'package:clothing_store_app/services/database/favorite_cloth.dart';
import 'package:clothing_store_app/services/database/search_history.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchText;
  const SearchResultScreen({super.key, required this.searchText});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.text = widget.searchText;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    return Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        body: Consumer<FilterProvider>(builder: (context, filterProvider, _) {
          return SingleChildScrollView(
            child: StreamBuilder(
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

                  Map<String, ClothBase> resClothes = filterClothesByName(
                    GlobalVar.listAllCloth,
                    searchText: widget.searchText,
                  );

                  resClothes = filterClothesByBrand(resClothes,
                      brand: filterProvider.chosenBrandIndex);
                  resClothes = filterClothesByGender(resClothes,
                      gender: filterProvider.chosenGenderIndex);
                  resClothes = filterClothesByReviews(resClothes,
                      minReview: filterProvider.reviewpoint);

                  return Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonDetailedAppBarView(
                                onPrefixIconClick: () {
                                  Navigator.pop(context);
                                },
                                title: AppLocalizations(context).of("search"),
                                prefixIconData: Icons.arrow_back),
                            const Padding(padding: EdgeInsets.all(12)),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    showCursor: false,
                                    readOnly: true,
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      fillColor: AppTheme.backgroundColor,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(0),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                          color: AppTheme.greyBackgroundColor,
                                          width: 0.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                          color: AppTheme.greyBackgroundColor,
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                          color: AppTheme.greyBackgroundColor,
                                          width: 0.5,
                                        ),
                                      ),
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Iconsax.search_normal_1,
                                            color: AppTheme.brownColor),
                                      ),
                                      hintText: AppLocalizations(context)
                                          .of("search"),
                                      hintStyle: TextStyles(context)
                                          .getLabelLargeStyle(true)
                                          .copyWith(),
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(4)),
                                TapEffect(
                                  onClick: () {
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppTheme.brownButtonColor,
                                    child: Icon(
                                      Iconsax.scanning,
                                      size: 20,
                                      color: AppTheme.iconColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(4)),
                            Row(
                              children: [
                                Text('Result for "${widget.searchText}"',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    SearchHistoryService().removeAllHistory();
                                  },
                                  style: TextButton.styleFrom(
                                    overlayColor: Colors.transparent,
                                  ),
                                  child: Text("${resClothes.length} founds",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(8)),
                            SizedBox(
                              height: size.height * 0.6,
                              child: buildProductGrid(resClothes,
                                  MediaQuery.of(context).size, favoriteIds),
                            ),
                          ]));
                }),
          );
        }));
  }

  Widget buildProductGrid(
      Map<String, ClothBase> clothes, Size size, List<String> favoriteList) {
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

  Map<String, ClothBase> filterClothesByName(
    Map<String, ClothBase> clothes, {
    required String searchText,
  }) {
    return Map.fromEntries(
      clothes.entries.where((entry) =>
          (entry.value.name.toLowerCase().contains(searchText.toLowerCase()))),
    );
  }

  Map<String, ClothBase> filterClothesByBrand(
    Map<String, ClothBase> clothes, {
    required int brand,
  }) {
    if (brand == 1) {
      return Map.fromEntries(
        clothes.entries.where((entry) => (entry.value.brand == 'Uniqlo')),
      );
    } else if (brand == 2) {
      return Map.fromEntries(
        clothes.entries.where((entry) => (entry.value.brand == 'Nike')),
      );
    } else if (brand == 3) {
      return Map.fromEntries(
        clothes.entries.where((entry) => (entry.value.brand == 'Addidas')),
      );
    } else if (brand == 4) {
      return Map.fromEntries(
        clothes.entries.where((entry) => (entry.value.brand == 'Puma')),
      );
    } else {
      return clothes;
    }
  }

  Map<String, ClothBase> filterClothesByGender(
    Map<String, ClothBase> clothes, {
    required int gender,
  }) {
    if (gender == 1) {
      return Map.fromEntries(
        clothes.entries.where((entry) => (entry.value.gender == 'M')),
      );
    } else if (gender == 2) {
      return Map.fromEntries(
        clothes.entries.where((entry) => (entry.value.gender == 'F')),
      );
    } else {
      return clothes;
    }
  }

  Future<Map<String, ClothBase>> filterClothesInPriceRange(
      Map<String, ClothBase> clothes,
      {required RangeValues priceRange}) async {
    final Map<String, ClothBase> filteredClothes = {};

    for (var entry in clothes.entries) {
      final clothItems = await entry.value.clothItems;
      if (clothItems.any((item) =>
          item.price >= priceRange.start && item.price <= priceRange.end)) {
        filteredClothes[entry.key] = entry.value;
      }
    }

    return filteredClothes;
  }

  // Map<String, ClothBase> filterClothesInPriceRange(
  //     Map<String, ClothBase> clothes,
  //     {required RangeValues priceRange}) {
  //   List<Map<String, dynamic>> data = [];
  //   List<String> validID = [];

  //   for (var entry in clothes.entries) {
  //     final clothBaseID = entry.value.id;
  //     validID.add(entry.value.id);
  //     FirebaseFirestore.instance
  //         .collection('Cloth')
  //         .doc(clothBaseID)
  //         .collection('ClothItem')
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       List<DocumentSnapshot<Object?>> dc = querySnapshot.docs;
  //       data.add(dc[0].data() as Map<String, dynamic>);
  //     });
  //   }
  //   print(data);

  //   for (int i = 0; i < data.length; ++i) {
  //     if (double.parse(data[i]['price']) < priceRange.start &&
  //         double.parse(data[i]['price']) > priceRange.end) {
  //       data.removeAt(i);
  //       validID.removeAt(i);
  //       --i;
  //     }
  //   }

  //   return Map.fromEntries(
  //     clothes.entries.where((entry) => validID.contains(entry.value.id)),
  //   );
  // }

  Map<String, ClothBase> filterClothesByReviews(
    Map<String, ClothBase> clothes, {
    required String minReview,
  }) {
    return Map.fromEntries(
      clothes.entries
          .where((entry) => entry.value.review >= double.parse(minReview)),
    );
  }
}
