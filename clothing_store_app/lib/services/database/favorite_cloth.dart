import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteClothService extends UserService {
  void addFavoriteCloth({required String clothItemID}) async {
    await userCollection
        .doc(uid)
        .collection("Wishlist")
        .doc(clothItemID)
        .set({
      'clothItemID': clothItemID,
    });
  }

  void removeFavoriteCloth({required String clothItemID}) async {
    await userCollection
        .doc(uid)
        .collection("Wishlist")
        .doc(clothItemID)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteClothStream() {
    return userCollection
        .doc(uid)
        .collection("Wishlist")
        .snapshots();
  }
}
