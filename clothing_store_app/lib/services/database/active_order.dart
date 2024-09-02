import 'dart:math';

import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ActiveOrderService extends UserService {
  void addOrder(
      {required double totalPrice, required List<dynamic> orderedItems}) async {
    String orderID = generateRandomString();
    await userCollection.doc(uid).collection("ActiveOrder").doc(orderID).set({
      'orderID': orderID,
      'totalPrice': totalPrice.toString(),
      'orderDate': DateFormat('MMM dd, yyyy').format(DateTime.now()).toString(),
      'totalItems': orderedItems.length,
    });

    for (int i = 0; i < orderedItems.length; i++) {
      await userCollection
          .doc(uid)
          .collection("ActiveOrder")
          .doc(orderID)
          .collection("Order")
          .doc(orderedItems[i]['clothItemID'])
          .set({
        'clothItemID': orderedItems[i]['clothItemID'],
        'name': orderedItems[i]['name'],
        'imageURL': orderedItems[i]['imageURL'],
        'size': orderedItems[i]['size'],
        'price': orderedItems[i]['price'],
        'orderQuantity': orderedItems[i]['orderQuantity'],
        'quantity': orderedItems[i]['quantity']
      });
    }
  }

  void removeOrder(
      {required String orderID,
      required String totalPrice,
      required String orderDate,
      required int totalItems}) async {
    await userCollection.doc(uid).collection("CancelOrder").doc(orderID).set({
      'orderID': orderID,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'totalItems': totalItems,
    });

    await userCollection
        .doc(uid)
        .collection("ActiveOrder")
        .doc(orderID)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrderStream() {
    return userCollection.doc(uid).collection("ActiveOrder").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrderDetailStream(
      {required String orderID}) {
    return userCollection
        .doc(uid)
        .collection("ActiveOrder")
        .doc(orderID)
        .collection("Order")
        .snapshots();
  }

  String generateRandomString([int length = 28]) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }
}
