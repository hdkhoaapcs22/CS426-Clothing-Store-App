import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveOrderService extends UserService {
  void addActiveOrder({required String orderID}) async {
    await userCollection.doc(uid).collection("ActiveOrder").doc(orderID).set({
      'orderID': orderID,
    });
  }

  void removeActiveOrder({required String orderID}) async {
    await userCollection
        .doc(uid)
        .collection("ActiveOrder")
        .doc(orderID)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserActiveOrderStream() {
    return userCollection.doc(uid).collection("ActiveOrder").snapshots();
  }
}
