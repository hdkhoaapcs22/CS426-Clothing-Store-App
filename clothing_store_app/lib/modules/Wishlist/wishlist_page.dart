import 'package:clothing_store_app/providers/wishlist_provider.dart';
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
  WishlistPage({super.key});
  final Stream<QuerySnapshot> couponStream = FirebaseFirestore.instance
      .collection('User')
      .doc('0MdSJIlGlYM7iYLueKbq3YP9wY73')
      .collection('Wishlist')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    List<String> categories = ['All', 'Jacket', 'Pants', 'Shirt', 'T-shirt'];
    return Consumer<WishlistProvider>(builder: (context, wishlistProvider, _) {
      return StreamBuilder<QuerySnapshot>(
          stream: couponStream,
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
            for (int i = 0; i < dc.length; ++i) {
              data.add(dc[i].data()! as Map<String, dynamic>);
            }

            List<Map<String, dynamic>> dataJacket = [];
            for (int i = 0; i < dc.length; ++i) {
              if (data[i]['type'] == 'jacket') {
                dataJacket.add(data[i]);
              }
            }

            List<Map<String, dynamic>> dataPant = [];
            for (int i = 0; i < dc.length; ++i) {
              if (data[i]['type'] == 'pant') {
                dataPant.add(data[i]);
              }
            }

            List<Map<String, dynamic>> dataShirt = [];
            for (int i = 0; i < dc.length; ++i) {
              if (data[i]['type'] == 'shirt') {
                dataShirt.add(data[i]);
              }
            }

            List<Map<String, dynamic>> dataTshirt = [];
            for (int i = 0; i < dc.length; ++i) {
              if (data[i]['type'] == 'tshirt') {
                dataTshirt.add(data[i]);
              }
            }

            return Scaffold(
              backgroundColor: AppTheme.scaffoldBackgroundColor,
              body: Padding(
                padding: EdgeInsets.fromLTRB(
                    24, AppBar().preferredSize.height, 24, 10),
                child: Column(
                  children: [
                    Row(children: [
                      const CommonAppBarView(iconData: Icons.arrow_back),
                      Expanded(
                        child: Center(
                          child: Text(
                            'My Wishlist        ',
                            style: TextStyles(context).getTitleStyle(),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 52,
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 52,
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
                        itemCount: chosenIndex == 0
                            ? data.length
                            : chosenIndex == 1
                                ? dataJacket.length
                                : chosenIndex == 2
                                    ? dataPant.length
                                    : chosenIndex == 3
                                        ? dataShirt.length
                                        : chosenIndex == 4
                                            ? dataTshirt.length
                                            : 0,
                        itemBuilder: (BuildContext context, int index) {
                          if (chosenIndex == 0) {
                            return productWishlistWidget(context, data, index);
                          } else if (chosenIndex == 1) {
                            return productWishlistWidget(
                                context, dataJacket, index);
                          } else if (chosenIndex == 2) {
                            return productWishlistWidget(
                                context, dataPant, index);
                          } else if (chosenIndex == 3) {
                            return productWishlistWidget(
                                context, dataShirt, index);
                          } else if (chosenIndex == 4) {
                            return productWishlistWidget(
                                context, dataTshirt, index);
                          } else {
                            return Container();
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
