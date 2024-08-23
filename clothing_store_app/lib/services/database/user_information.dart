import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'user.dart';

class UserInformationService extends UserService {
  UserInformationService() : super.defaultContructor();

  Future setUserInformation({
    required String name,
    required String phone,
    required String email,
  }) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'phone': phone, 'mail': email, 'imageUrl': ''});
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
    required String email,
    required String fileImageName,
    Uint8List? image,
  }) async {
    if (image != null) {
      String imageUrl = await uploadImageToStorage(fileImageName, image);
      return await userCollection.doc(uid).update({
        'name': name,
        'phone': phone,
        'mail': email,
        'imageUrl': imageUrl,
      });
    }
    return await userCollection.doc(uid).update({
      'name': name,
      'phone': phone,
      'mail': email,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfomationStream() {
    return userCollection.doc(uid).snapshots();
  }
}
