import 'package:flutter/material.dart';

class CommonTwoOptionsDialog extends StatelessWidget {
  final String title;
  final String message;
  final String option1Text;
  final String option2Text;
  final VoidCallback onOption1Pressed;
  final VoidCallback onOption2Pressed;

  const CommonTwoOptionsDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.option1Text,
    required this.option2Text,
    required this.onOption1Pressed,
    required this.onOption2Pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onOption1Pressed,
          child: Text(option1Text),
        ),
        TextButton(
          onPressed: onOption2Pressed,
          child: Text(option2Text),
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
