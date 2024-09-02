import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class CancelledOrderService extends UserService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getCancelledOrderStream() {
    return userCollection.doc(uid).collection("CancelOrder").snapshots();
  }
}
