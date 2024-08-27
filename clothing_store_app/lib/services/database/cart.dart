import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartService extends UserService {
  CartService() : super.defaultContructor();

  void addItemIntoCart({
    required String clothItemID,
    required String name,
    required String imageURl,
    required String size,
    required double price,
    required int orderQuantity,
  }) async {
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).set({
      'clothItemID': clothItemID,
      'name': name,
      'imageURl': imageURl,
      'size': size,
      'price': price,
      'orderQuantity': orderQuantity,
    });
  }

  void removeItemFromCart({required String clothItemID}) async {
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).delete();
  }

  void increaseQuantityOrderItemInCart({required String clothItemID}) async{
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).update({
      'orderQuantity': FieldValue.increment(1),
    });
  }

  void decreaseQuantityOrderItemInCart({required String clothItemID}) async{
    await userCollection.doc(uid).collection("Cart").doc(clothItemID).update({
      'orderQuantity': FieldValue.increment(-1),  
    });
  }

  Future<Stream<QuerySnapshot>> getItemInCartStream() async {
    return FirebaseFirestore.instance.collection("User").doc(uid).collection("Cart").snapshots();
  }
}
