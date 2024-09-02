import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ApiService {
  CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('APIKey');
}
