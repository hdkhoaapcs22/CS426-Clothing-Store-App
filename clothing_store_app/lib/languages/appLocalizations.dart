import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/common.dart' as common;
import '../clothing_store_app.dart';
import '../providers/theme_provider.dart';
import '../utils/enum.dart';

class AppLocalizations {
  final BuildContext context;

  AppLocalizations(this.context);

  // call this method only firstTime when open app You can see splash_screen.dart
  Future<void> load() async {
    final List<Map<String, String>> allTexts = [];

    List<dynamic> jsonData = json.decode(
      await DefaultAssetBundle.of(context)
          .loadString('lib/languages/lang/language_text.json'),
    );

    for (var value in jsonData) {
      if (value is Map && value['text_id'] != null) {
        Map<String, String> texts = {};
        texts['text_id'] =
            value['text_id'] ?? ''; // if text_id is null, then ''
        texts['en'] = value['en'] ?? '';
        texts['fr'] = value['fr'] ?? '';
        allTexts.add(texts);
      }
    }
    common.globalTexts = allTexts;
  }

  String of(String textId) {
    LanguageType languageType = applicationcontext == null
        ? LanguageType.en
        : applicationcontext!.read<ThemeProvider>().languageType;
    final Locale myLocale = Localizations.localeOf(context);
    if (myLocale.languageCode != '' && myLocale.languageCode.length == 2) {
      if (common.globalTexts != null && common.globalTexts!.isNotEmpty) {
        String newtext = '';
        final index = common.globalTexts!
            .indexWhere((element) => element['text_id'] == textId);
        if (index != -1) {
          newtext = common.globalTexts![index]
                  [languageType.toString().split(".")[1]] ??
              '';
          if (newtext != '') return newtext;
        }
        return '#Text is Empty#';
      } else {
        return '#Language is Empty#';
      }
    } else {
      return '#LanguageCode Not Match#';
    }
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  getBoldStyle() {}
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localization = AppLocalizations(applicationcontext!);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
