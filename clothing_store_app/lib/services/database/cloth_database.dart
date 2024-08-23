import 'package:cloud_firestore/cloud_firestore.dart';

import '../../class/cloth_item.dart';
import '../../global/global_var.dart';

class ClothService {
  void getAllClothItems() async {
    QuerySnapshot<Map<String, dynamic>> value =
        await FirebaseFirestore.instance.collection("ClothItem").get();

    GlobalVar.listAllClothItems = value.docs
        .map((doc) => ClothItem(
              type: doc['type'],
              size: doc['size'],
              gender: doc['gender'],
              brand: doc['brand'],
              clothImageURL: doc['clothImageURL'],
              price: doc['price'],
              review: doc['review'],
              quantity: doc['quantity'],
            ))
        .toList();
  }
}
