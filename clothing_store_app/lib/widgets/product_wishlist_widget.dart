import 'package:clothing_store_app/services/database/favorite_cloth.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

Widget productWishlistWidget(BuildContext context, Map<String, dynamic> data) {
  return Column(
    children: [
      Stack(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(data['imageURL'], width: 180)),
        Positioned(
            top: 10,
            right: -10,
            child: ElevatedButton(
              onPressed: () {
                FavoriteClothService()
                    .removeFavoriteCloth(clothItemID: data['clothItemID']);
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(100, 255, 255, 255)),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(1)),
                  Image.asset(Localfiles.wishlistHeart),
                ],
              ),
            ))
      ]),
      const Padding(padding: EdgeInsets.all(2)),
      SizedBox(
        width: 180,
        child: Row(
          children: [
            Text(
              data['name'],
            ),
            const Spacer(),
            Image.asset(Localfiles.yellowStar),
            Text(data['review'],
                style: TextStyles(context).getDescriptionStyle()),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.all(4)),
      SizedBox(
        width: 180,
        child: Row(
          children: [
            Text(
              '\$${data['price']}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
          ],
        ),
      ),
    ],
  );
}
