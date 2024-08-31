import 'package:clothing_store_app/services/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryService extends UserService {
  void addHistory({required String hisID, required String content}) async {
    await userCollection.doc(uid).collection("SearchHistory").doc(hisID).set({
      'hisID': hisID,
      'content': content,
    });
  }

  void removeHistory({required String hisID}) async {
    await userCollection
        .doc(uid)
        .collection("SearchHistory")
        .doc(hisID)
        .delete();
  }

  void removeAllHistory() async {
    var collection = userCollection.doc(uid).collection("SearchHistory");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSearchHistoryStream() {
    return userCollection
        .doc(uid)
        .collection("SearchHistory")
        .orderBy(FieldPath.documentId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSearchResultStream(
      {required String id}) {
    return userCollection
        .doc(uid)
        .collection("SearchHistory")
        .orderBy(FieldPath.documentId)
        .snapshots();
  }
}
