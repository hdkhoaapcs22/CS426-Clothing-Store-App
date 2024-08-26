import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_button.dart';

class InviteButton extends StatelessWidget {
  final VoidCallback onPressed;

  InviteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.brown),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        AppLocalizations(context).of("invite"),
        style: TextStyle(
          color: Colors.brown,
          fontSize: 16,
        ),
      ),
    );
  }
}
