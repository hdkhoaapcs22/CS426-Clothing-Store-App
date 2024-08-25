import 'package:clothing_store_app/providers/complete_profile_provider.dart';
import 'package:clothing_store_app/providers/set_image_provider.dart';
import 'package:clothing_store_app/providers/sign_up_provider.dart';
import 'package:clothing_store_app/providers/theme_provider.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/clothing_store_app.dart';
import 'package:clothing_store_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'services/database/cloth_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(_setAllProviders()));
}

Widget _setAllProviders() {
        var tmp = FirebaseFirestore.instance.collection("Cloth");
      ClothService clothService = ClothService(tmp);
      clothService.getAllClothes();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(
          state: AppTheme.getThemeData,
        ),
      ),
      ChangeNotifierProvider(
          create: (_) => PickImageProvider(),
      ),
      ChangeNotifierProvider(
          create: (_) => SignUpNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => CompleteProfileNotifier(),
      ),
    ],
    child: ClothingStoreApp(),
  );
}
