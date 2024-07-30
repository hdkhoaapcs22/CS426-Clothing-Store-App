import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:flutter/material.dart';

class CommonOKDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onOKPressed;

  const CommonOKDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onOKPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onOKPressed,
          child: Text(AppLocalizations(context).of("ok")),
        ),
      ],
    );
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }
}