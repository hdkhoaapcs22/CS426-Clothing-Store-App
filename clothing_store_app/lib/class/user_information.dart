import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation {
  final String userId;
  final String name;
  final String phone;
  final String imageUrl;

  UserInformation({
    required this.userId,
    required this.name,
    required this.phone,
    required this.imageUrl,
  });

  factory UserInformation.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return UserInformation(
      userId: doc.id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
