import 'package:clothing_store_app/services/database/active_order.dart';
import 'package:clothing_store_app/services/database/cancelled_order.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'favorite_cloth.dart';

class UserService {
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('User');
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late UserInformationService userInformationService;
  late FavoriteClothService favoriteClothService;
  late ActiveOrderService activeOrderService;
  late CancelledOrderService cancelledOrderService;

  UserService() {
    favoriteClothService = FavoriteClothService();
    userInformationService = UserInformationService();
    activeOrderService = ActiveOrderService();
    cancelledOrderService = CancelledOrderService();
  }
  UserService.defaultContructor();
}
