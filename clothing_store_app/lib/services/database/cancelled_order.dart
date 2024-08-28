import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class CancelledOrderService extends UserService {
  void addCancelledOrder({required String orderID}) async {
    await userCollection
        .doc(uid)
        .collection("CancelledOrder")
        .doc(orderID)
        .set({
      'orderID': orderID,
    });
  }

  void removeCancelledOrder({required String orderID}) async {
    await userCollection
        .doc(uid)
        .collection("CancelledOrder")
        .doc(orderID)
        .delete();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCancelledOrderStream() {
    return userCollection
        .doc(uid)
        .collection("CancelledOrder")
        .doc()
        .snapshots();
  }
}
