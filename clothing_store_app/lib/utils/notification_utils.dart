import 'package:flutter/material.dart';

import '../languages/appLocalizations.dart';
import '../routes/navigation_services.dart';
import '../widgets/common_OK_dialog.dart';
import '../widgets/common_two_options_dialog.dart';

mixin NotificationUtils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations(context).of(message)),
    ));
  }

  static void showOKDialog(BuildContext context, String message) {
    CommonOKDialog(
      title: AppLocalizations(context).of("notification"),
      message: AppLocalizations(context).of(message),
      onOKPressed: () {
        Navigator.of(context).pop();
        NavigationServices(context).pop();
      },
    ).show(context);
  }

  static void showTwoOptionsDialog(BuildContext context, String message,
      String option1Text, String option2Text, Function onOption2Pressed) {
    CommonTwoOptionsDialog(
      title: AppLocalizations(context).of("notification"),
      message: AppLocalizations(context).of(message),
      option1Text: AppLocalizations(context).of(option1Text),
      option2Text: AppLocalizations(context).of(option2Text),
      onOption1Pressed: () {
        Navigator.of(context).pop();
      },
      onOption2Pressed: () {
        Navigator.of(context).pop();
        onOption2Pressed();
      },
    ).show(context);
  }
}
