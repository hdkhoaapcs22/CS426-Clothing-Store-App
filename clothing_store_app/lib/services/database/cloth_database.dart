import 'package:cloud_firestore/cloud_firestore.dart';

import '../../class/cloth_item.dart';
import '../../global/global_var.dart';

class ClothService {
  CollectionReference<Map<String, dynamic>> collection;
  ClothService(this.collection);

  void getAllClothes() async {
    QuerySnapshot<Map<String, dynamic>> value = await collection.get();

    for (var doc in value.docs) {
      GlobalVar.listAllCloth[doc.reference.id] = ClothBase(
        name: doc['name'],
        description: doc['description'],
        type: doc['type'],
        gender: doc['gender'],
        brand: doc['brand'],
        clothItems: getClothItems(id: doc.reference.id),
      );
    }
  }

  Future<List<ClothItem>> getClothItems({required String id}) async {
    QuerySnapshot<Map<String, dynamic>> value =
        await collection.doc(id).collection('ClothItem').get();

    List<ClothItem> listClothItems = [];
    listClothItems = value.docs
        .map((doc) => ClothItem(
              color: doc['color'],
              clothImageURL: doc['clothImageURL'],
              sizeWithQuantity: doc['sizeWithQuantity'],
              price: double.parse(doc['price']),
              review: double.parse(doc['review']),
            ))
        .toList();

    return listClothItems;
  }
}
