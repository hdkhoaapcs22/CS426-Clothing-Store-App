import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('User');
      
  String uid = FirebaseAuth.instance.currentUser!.uid;
}
