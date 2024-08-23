import 'package:clothing_store_app/services/database/active_order.dart';
import 'package:clothing_store_app/services/database/cancelled_order.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'favorite_cloth.dart';

class UserService {
  late CollectionReference<Map<String, dynamic>> userCollection;
  late String uid;
  late UserInformationService userInformationService;
  late FavoriteClothService favoriteClothService;
  late ActiveOrderService activeOrderService;
  late CancelledOrderService cancelledOrderService;

  UserService({required this.uid, required this.userCollection}) {
    favoriteClothService = FavoriteClothService();
    userInformationService = UserInformationService();
    activeOrderService = ActiveOrderService();
    cancelledOrderService = CancelledOrderService();
  }

  UserService.defaultContructor();
}
