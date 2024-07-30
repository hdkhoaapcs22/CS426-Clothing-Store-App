import 'package:clothing_store_app/common/common.dart';
import 'package:clothing_store_app/providers/address_model.dart';
import 'package:clothing_store_app/providers/theme_provider.dart';
import 'package:clothing_store_app/repositories/address_repository.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/clothing_store_app.dart';
import 'package:clothing_store_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await loadVietnameseProvinceDataFromJsonFile();

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(_setAllProviders()));
}

Widget _setAllProviders() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(
          state: AppTheme.getThemeData,
        ),
      ),

      // Add more providers here
      ChangeNotifierProvider(create: (_) => AddressModel()),

      // Add repository providers here
      Provider<AddressRepository>(
        create: (_) => AddressRepository("aMPjhNJSHfscG2aYNlPA"), // userId
      ),
    ],
    child: ClothingStoreApp(),
  );
}
