import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveOrderService extends UserService {
  ActiveOrderService() : super.defaultContructor();

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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserActiveOrder() {
    return userCollection.doc(uid).collection("ActiveOrder").doc().snapshots();
  }
}
