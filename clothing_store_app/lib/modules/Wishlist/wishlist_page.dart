import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/providers/wishlist_provider.dart';
import 'package:clothing_store_app/services/database/favorite_cloth.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_app_bar_view.dart';
import 'package:clothing_store_app/widgets/product_wishlist_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    List<String> categories = ['All', 'Jacket', 'Pants', 'Shirt', 'T-shirt'];

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
            List<Map<String, dynamic>> data = [];
            List<Map<String, dynamic>> subData = [];
            subData.clear();
            for (int i = 0; i < dc.length; ++i) {
              data.add(dc[i].data()! as Map<String, dynamic>);
              if (chosenIndex == 1 && data[i]['type'] == 'jacket') {
                subData.add(data[i]);
              } else if (chosenIndex == 2 && data[i]['type'] == 'pant') {
                subData.add(data[i]);
              } else if (chosenIndex == 3 && data[i]['type'] == 'shirt') {
                subData.add(data[i]);
              } else if (chosenIndex == 4 && data[i]['type'] == 'tshirt') {
                subData.add(data[i]);
              }
            }

            return Scaffold(
              backgroundColor: AppTheme.scaffoldBackgroundColor,
              body: Padding(
                padding: EdgeInsets.fromLTRB(
                    24, AppBar().preferredSize.height, 24, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      const CommonAppBarView(iconData: Icons.arrow_back),
                      Expanded(
                        child: Center(
                          child: Text(
                            AppLocalizations(context).of("wishlist_title"),
                            style: TextStyles(context).getTitleStyle(),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: ElevatedButton(
                                onPressed: () {
                                  wishlistProvider.update(index);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: chosenIndex == index
                                        ? const Color.fromRGBO(88, 57, 39, 1)
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
                    const Padding(padding: EdgeInsets.all(4)),
                    GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 246,
                        ),
                        itemCount:
                            chosenIndex == 0 ? data.length : subData.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (chosenIndex == 0) {
                            return productWishlistWidget(context, data[index]);
                          } else {
                            return productWishlistWidget(
                                context, subData[index]);
                          }
                        }),
                  ],
                ),
              ),
            );
          });
    });
  }
}
