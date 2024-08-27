import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartService extends UserService {
  CartService() : super.defaultContructor();

  void addItemIntoCart({
    required String clothItemID,
    required String name,
    required String imageURl,
    required String size,
    required double price,
    required int orderQuantity,
  }) async {
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).set({
      'clothItemID': clothItemID,
      'name': name,
      'imageURl': imageURl,
      'size': size,
      'price': price,
      'orderQuantity': orderQuantity,
    });
  }

  void removeItemFromCart({required String clothItemID}) async {
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).delete();
  }

  void increaseQuantityOrderItemInCart({required String clothItemID}) async {
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).update({
      'orderQuantity': FieldValue.increment(1),
    });
  }

  void decreaseQuantityOrderItemInCart({required String clothItemID}) async {
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).update({
      'orderQuantity': FieldValue.increment(-1),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getItemInCartStream() {
    return userCollection.doc(uid).collection("Cart").snapshots();
  }

  Future<void> moveItemsToActiveOrder({
    required String orderID,
    String? couponID,
    required double subTotalPrice,
    required double totalPrice,
    required double deliveryFee,
    required double discount,
  }) async {
    final cartSnapshot = await userCollection.doc(uid).collection("Cart").get();
    final batch = FirebaseFirestore.instance.batch();

    List<Map<String, dynamic>> clothesSold = [];

    for (var doc in cartSnapshot.docs) {
      final data = doc.data();
      final clothItemID = doc.id;

      clothesSold.add(data);

      batch.set(
        userCollection
            .doc(uid)
            .collection("ActiveOrder")
            .doc(orderID)
            .collection("Items")
            .doc(clothItemID),
        data,
      );

      batch.delete(userCollection.doc(uid).collection("Cart").doc(clothItemID));
    }

    batch.set(
      userCollection.doc(uid).collection("ActiveOrder").doc(orderID),
      {
        'orderID': orderID,
        'timestamp': FieldValue.serverTimestamp(),
        'prizeBeforeCoupon': subTotalPrice,
        'totalPrize': totalPrice,
        'clothesSold': clothesSold,
        'couponID': couponID,
        'discount': discount,
        'deliveryFee': deliveryFee,
        'subTotalPrice': subTotalPrice,
      },
    );

    await batch.commit();
  }
}
