import 'package:cloud_firestore/cloud_firestore.dart';

class CouponService {
  void deleteCoupon({required String couponID}) async {
    await FirebaseFirestore.instance
        .collection("Coupon")
        .doc(couponID)
        .delete();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCouponStream() {
    return FirebaseFirestore.instance.collection("Coupon").doc().snapshots();
  }
}
