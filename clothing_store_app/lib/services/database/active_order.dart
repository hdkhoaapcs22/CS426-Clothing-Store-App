import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveOrderService extends UserService {
  ActiveOrderService() : super.defaultContructor();

  Future<String> addActiveOrder({
    required double subTotalPrice,
    required double totalPrice,
    required double deliveryFee,
    required List<Map<String, dynamic>> clothesSold,
    String? couponID,
    double? discount,
  }) async {
    DocumentReference orderRef =
        userCollection.doc(uid).collection("ActiveOrder").doc();
    String orderID = orderRef.id;

    await orderRef.set({
      'orderID': orderID,
      'timestamp': FieldValue.serverTimestamp(),
      'prizeBeforeCoupon': subTotalPrice,
      'totalPrize': totalPrice,
      'deliveryFee': deliveryFee,
      'clothesSold': clothesSold,
      'couponID': couponID,
      'discount': discount,
    });

    return orderID;
  }

  void removeActiveOrder({required String orderID}) async {
    await userCollection
        .doc(uid)
        .collection("ActiveOrder")
        .doc(orderID)
        .delete();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserActiveOrderStream(
      {required String orderID}) {
    return userCollection
        .doc(uid)
        .collection("ActiveOrder")
        .doc(orderID)
        .snapshots();
  }
}
