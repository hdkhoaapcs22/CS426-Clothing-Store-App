import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'user.dart';
import 'package:clothing_store_app/class/user_information.dart';

class UserInformationService extends UserService {
  Future setUserInformation({
    required String name,
    required String phone,
    required String fileImageName,
    List<Map<String, dynamic>>? notifications,
    List<String>? friends,
    List<String>? friendRequests,
    Uint8List? image,
  }) async {
    String imageUrl = '';
    if (image != null) {
      imageUrl = await uploadImageToStorage(fileImageName, image);
    }
    return await userCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'imageUrl': imageUrl,
    });
  }

  Future<String> uploadImageToStorage(String fileName, Uint8List image) async {
    final Reference storageRef = FirebaseStorage.instance.ref();

    final Reference imageFolderRef = storageRef.child("User");
    Reference fileImageRef = imageFolderRef.child(fileName);

    TaskSnapshot taskSnapshot = await fileImageRef.putData(image);

    return await taskSnapshot.ref.getDownloadURL();
  }

  Future updateUserInformation({
    required String name,
    required String phone,
    String? fileImageName,
    Uint8List? image,
  }) async {
    if (image != null) {
      String imageUrl = await uploadImageToStorage(fileImageName!, image);
      return await userCollection.doc(uid).update({
        'name': name,
        'phone': phone,
        'imageUrl': imageUrl,
      });
    }
    return await userCollection.doc(uid).update({
      'name': name,
      'phone': phone,
    });
  }

  Future addNotification(Map<String, dynamic> notification) async {
    return await userCollection.doc(uid).update({
      'notifications': FieldValue.arrayUnion([notification]),
    });
  }

  Future addNotificationWithAnotherId(
      String userID, Map<String, dynamic> notification) async {
    return await userCollection.doc(userID).update({
      'notifications': FieldValue.arrayUnion([notification]),
    });
  }

  Future addNotificationWithPos(
      Map<String, dynamic> notification, int pos) async {
    await userCollection.doc(uid).update({
      'notifications': FieldValue.arrayRemove([notification]),
    });

    DocumentSnapshot<Map<String, dynamic>> userData =
        await userCollection.doc(uid).get();

    List<dynamic> notifications = List.from(userData['notifications']);

    notifications.insert(pos, notification);

    return await userCollection.doc(uid).update({
      'notifications': notifications,
    });
  }

  Future deleteNotification(Map<String, dynamic> notification) async {
    return await userCollection.doc(uid).update({
      'notifications': FieldValue.arrayRemove([notification]),
    });
  }

  Future addFriendRequest(String userID) async {
    return await userCollection.doc(userID).update({
      'friendRequests': FieldValue.arrayUnion([uid]),
    });
  }

  Future acceptFriendRequest(String userID) async {
    DocumentSnapshot<Map<String, dynamic>> currentUserSnapshot =
        await userCollection.doc(uid).get();

    DocumentSnapshot<Map<String, dynamic>> friendSnapshot =
        await userCollection.doc(userID).get();

    List<String> currentUserFriends =
        List<String>.from(currentUserSnapshot.data()?['friends'] ?? []);

    List<String> friendUserFriends =
        List<String>.from(friendSnapshot.data()?['friends'] ?? []);

    if (!currentUserFriends.contains(userID)) {
      currentUserFriends.add(userID);
    }

    if (!friendUserFriends.contains(uid)) {
      friendUserFriends.add(uid);
    }

    await userCollection.doc(uid).update({
      'friends': currentUserFriends,
    });

    await userCollection.doc(userID).update({
      'friends': friendUserFriends,
    });

    await userCollection.doc(uid).update({
      'friendRequests': FieldValue.arrayRemove([userID]),
    });
  }

  Future denyFriendRequest(String userID) async {
    await userCollection.doc(uid).update({
      'friendRequests': FieldValue.arrayRemove([userID]),
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfomationStream() {
    return userCollection.doc(uid).snapshots();
  }

  Future deleteUser() async {
    return await userCollection.doc(uid).delete();
  }

  Stream<UserInformation> getUserInformationStream(String userID) {
    return userCollection.doc(userID).snapshots().map((snapshot) {
      return UserInformation.fromFirestore(snapshot);
    });
  }

  Stream<List<UserInformation>> getListUserInformationStream() async* {
    DocumentSnapshot<Map<String, dynamic>> currentUserSnapshot =
        await userCollection.doc(uid).get();

    List<String> friends =
        List<String>.from(currentUserSnapshot.data()?['friends'] ?? []);

    yield* userCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != uid && !friends.contains(doc.id))
          .map((doc) => UserInformation.fromFirestore(doc))
          .toList();
    });
  }
}
