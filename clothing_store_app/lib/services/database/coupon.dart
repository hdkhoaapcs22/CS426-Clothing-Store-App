import 'package:cloud_firestore/cloud_firestore.dart';

class CouponService {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCouponStream(
      String couponID) {
    return FirebaseFirestore.instance
        .collection("Coupon")
        .doc(couponID)
        .snapshots();
  }

  Future<void> decreaseCouponQuantity(String? couponID) async {
    final couponDoc =
        FirebaseFirestore.instance.collection("Coupon").doc(couponID);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(couponDoc);

      if (!snapshot.exists) {
        throw Exception("Coupon does not exist!");
      }

      int currentQuantity = snapshot.data()!['quantity'];

      if (currentQuantity <= 0) {
        throw Exception("Quantity is already zero!");
      }

      int newQuantity = currentQuantity - 1;

      if (newQuantity == 0) {
        transaction.delete(couponDoc);
      } else {
        transaction.update(couponDoc, {'quantity': newQuantity});
      }
    });
  }
}
