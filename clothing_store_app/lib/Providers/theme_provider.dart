import 'package:flutter/material.dart';
import '../clothing_store_app.dart';
import '../utils/shared_preferences_keys.dart';
import '../utils/themes.dart';
import '../utils/enum.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({required ThemeData state}) : super();

  bool _isLightMode = true;
  bool get isLightMode => _isLightMode;

  ThemeData _themeData = AppTheme.getThemeData;
  ThemeData get themeData => _themeData;

  ThemeModeType _themeModeType = ThemeModeType.system;
  ThemeModeType get themeModeType => _themeModeType;

  FontFamilyType get fontType => _fontType;
  FontFamilyType _fontType = FontFamilyType.WorkSans;

  ColorType get colorType => _colorType;
  ColorType _colorType = ColorType.Verdigris;

  LanguageType _languageType = LanguageType.en;
  LanguageType get languageType => _languageType;

  updateThemeMode(ThemeModeType settingThemeModeType) async {
    final systembrightness = MediaQuery.of(applicationcontext!)
        .platformBrightness; //helps to obtain the brightness of the device
    _themeModeType = settingThemeModeType;
    checkAndSetThemeMode(settingThemeModeType == ThemeModeType.light
        ? Brightness.light
        : settingThemeModeType == ThemeModeType.dark
            ? Brightness.dark
            : systembrightness);
  }

// this func is auto check theme and update them
  void checkAndSetThemeMode(Brightness systemBrightness) async {
    bool _theLightTheme = _isLightMode;

    // mode is selected by user
    if (_themeModeType == ThemeModeType.system) {
      // if mode is system then we add as system birtness
      _theLightTheme = systemBrightness == Brightness.light;
    } else if (_themeModeType == ThemeModeType.dark) {
      _theLightTheme = false;
    } else {
      //light theme selected by user
      _theLightTheme = true;
    }

    if (_isLightMode != _theLightTheme) {
      _isLightMode = _theLightTheme;
      _themeData = AppTheme.getThemeData;
      notifyListeners();
    }
  }

  void updateLanguage(LanguageType _language) async {
    await SharedPreferencesKeys().setLanguageType(_language);
    _languageType = _language;
    _themeData = AppTheme.getThemeData;
    notifyListeners();
  }
}
