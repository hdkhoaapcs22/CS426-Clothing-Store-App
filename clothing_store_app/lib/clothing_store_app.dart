import 'dart:io';

import 'package:clothing_store_app/modules/CheckoutScreen/checkout_screen.dart';
import 'package:clothing_store_app/modules/ChooseShippingScreen/choose_shipping_screen.dart';
import 'package:clothing_store_app/modules/PaymentMethodsScreen/payment_methods_screen.dart';
import 'package:clothing_store_app/modules/PaymentSuccessfulScreen/payment_successful_screen.dart';
import 'package:clothing_store_app/modules/ShippingAddressScreen/shipping_address_screen.dart';
import 'package:clothing_store_app/modules/AddCardScreen/add_card_screen.dart';
// import 'package:clothing_store_app/modules/SplashScreen/splash_screen.dart';
import 'package:clothing_store_app/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'common/common.dart';
import 'languages/appLocalizations.dart';

BuildContext? applicationcontext;

class ClothingStoreApp extends StatefulWidget {
  @override
  _ClothingStoreAppState createState() => _ClothingStoreAppState();
}

class _ClothingStoreAppState extends State<ClothingStoreApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (_, provider, child) {
      applicationcontext = context;
      final ThemeData theme = provider.themeData;
      return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
          ],
          navigatorKey: navigatorKey,
          title: 'Clothing Store App',
          debugShowCheckedModeBanner: false,
          theme: theme,
          routes: _buildRoutes(),
          builder: (BuildContext context, Widget? child) {
            _setFirstTimeSomeData(context, theme);
            return Directionality(
                textDirection: TextDirection.ltr,
                child: Builder(
                  builder: (BuildContext context) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: TextScaler.linear(
                            MediaQuery.of(context).size.width > 360
                                ? 1.0
                                : (MediaQuery.of(context).size.width >= 340
                                    ? 0.9
                                    : 0.8)),
                      ),
                      child: child ?? const SizedBox(),
                    );
                  },
                ));
          });
    });
  }

  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    applicationcontext = context;
    _setStatusBarNavigationBarTheme(theme);
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.splashScreen: (context) => CheckoutScreen(),
    };
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? (themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light)
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.scaffoldBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }
}
