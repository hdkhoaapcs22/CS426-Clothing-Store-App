import 'package:clothing_store_app/providers/wishlist_provider.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_app_bar_view.dart';
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

            List<DocumentSnapshot<Object?>> dc = snapshot.data!.docs;
            List<Map<String, dynamic>> data = [];
            for (int i = 0; i < dc.length; ++i) {
              data.add(dc[i].data()! as Map<String, dynamic>);
            }

            return Scaffold(
              backgroundColor: AppTheme.scaffoldBackgroundColor,
              body: Padding(
                padding: EdgeInsets.fromLTRB(
                    24, AppBar().preferredSize.height, 24, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 56,
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  wishlistProvider.update(index);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: wishlistProvider
                                                .chosenIndex ==
                                            index
                                        ? const Color.fromRGBO(88, 57, 39, 1)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: Text(categories[index],
                                    style: TextStyle(
                                        color: wishlistProvider.chosenIndex ==
                                                index
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                88, 57, 39, 1))),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 600,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              child: Image.network(data[index]['imageURL']),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
