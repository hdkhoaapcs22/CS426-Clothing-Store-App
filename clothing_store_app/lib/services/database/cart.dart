import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clothing_store_app/class/order_info.dart';
import 'package:clothing_store_app/services/database/coupon.dart';
import 'package:intl/intl.dart';

class CartService extends UserService {
  void addItemIntoCart(
      {required String clothItemID,
      required String name,
      required String imageURl,
      required String size,
      required double price,
      required int orderQuantity,
      required int quantity}) async {
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).set({
      'clothItemID': clothItemID,
      'name': name,
      'imageURL': imageURl,
      'size': size,
      'price': price.toString(),
      'orderQuantity': orderQuantity,
      'quantity': quantity
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

  Future<void> moveItemsToActiveOrder({required OrderInfo order}) async {
    final cartSnapshot = await userCollection.doc(uid).collection("Cart").get();
    final batch = FirebaseFirestore.instance.batch();

    final orderDocRef = userCollection.doc(uid).collection("ActiveOrder").doc();
    final orderID = orderDocRef.id;

    for (var doc in cartSnapshot.docs) {
      final clothItemID = doc.id;

      batch.delete(userCollection.doc(uid).collection("Cart").doc(clothItemID));
    }

    if (order.couponID != null) {
      for (var couponID in order.couponID!) {
        CouponService().decreaseCouponQuantity(couponID);
      }
    }

    String orderDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    batch.set(
      orderDocRef,
      {
        'orderID': orderID,
        'orderDate': orderDate,
        'subTotalPrice': order.subTotalPrice,
        'totalPrice': order.totalPrice,
        'clothesSold': order.clothesSold,
        'couponID': order.couponID,
        'discount': order.discount,
        'deliveryFee': order.deliveryFee,
        'shippingAddress': order.shippingAddress,
        'shippingType': order.shippingType,
        'beginShippingDate': order.beginShippingDate,
        'endShippingDate': order.endShippingDate,
        'paymentMethod': order.paymentMethod,
        'totalItems': order.totalItems,
      },
    );

    await batch.commit();
  }
}
