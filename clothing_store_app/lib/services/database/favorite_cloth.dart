import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteClothService extends UserService {
  FavoriteClothService() : super.defaultContructor();

  void addFavoriteCloth({required String clothItemID}) async {
    await userCollection
        .doc(uid)
        .collection("FavoriteCloth")
        .doc(clothItemID)
        .set({
      'clothItemID': clothItemID,
    });
  }

  void removeFavoriteCloth({required String clothItemID}) async {
    await userCollection
        .doc(uid)
        .collection("FavoriteCloth")
        .doc(clothItemID)
        .delete();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getFavoriteClothStream() {
    return userCollection
        .doc(uid)
        .collection("FavoriteCloth")
        .doc()
        .snapshots();
  }
}
