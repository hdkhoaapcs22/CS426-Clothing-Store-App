import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../languages/appLocalizations.dart';
import '../../services/auth/auth_service.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_detailed_app_bar.dart';
import '../../widgets/common_dialogs.dart';
import '../../widgets/label_and_textfield.dart';

class PassWordManagerScreen extends StatefulWidget {
  const PassWordManagerScreen({super.key});

  @override
  State<PassWordManagerScreen> createState() => _PassWordManagerScreenState();
}

class _PassWordManagerScreenState extends State<PassWordManagerScreen> {
  late TextEditingController oldPassController,
      newPassController,
      confirmPassController;
  late String oldPasswordError, newPasswordError, confirmPasswordError;

  @override
  void initState() {
    oldPassController = TextEditingController();
    newPassController = TextEditingController();
    confirmPassController = TextEditingController();
    oldPasswordError = '';
    newPasswordError = '';
    confirmPasswordError = '';
    super.initState();
  }

  @override
  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("password_manager"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            SizedBox(height: size.height / 16),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: labelAndTextField(
                  context: context,
                  label: "current_password",
                  hintText: '********',
                  controller: oldPassController,
                  errorText: oldPasswordError,
                  suffixIconData: Iconsax.eye_slash,
                  selectedIconData: Iconsax.eye,
                  isObscured: true),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: labelAndTextField(
                  context: context,
                  label: "new_password",
                  hintText: '********',
                  controller: newPassController,
                  errorText: newPasswordError,
                  suffixIconData: Iconsax.eye_slash,
                  selectedIconData: Iconsax.eye,
                  isObscured: true),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: labelAndTextField(
                  context: context,
                  label: "confirm_new_password",
                  hintText: '********',
                  controller: confirmPassController,
                  errorText: confirmPasswordError,
                  suffixIconData: Iconsax.eye_slash,
                  selectedIconData: Iconsax.eye,
                  isObscured: true),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: size.height / 11,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CommonButton(
              onTap: () {
                handleChangePassword();
              },
              buttonText: 'change_password',
              radius: 40,
            ),
          ),
        ),
      ),
    );
  }

  void handleChangePassword() async {
    setState(() {
      oldPasswordError = '';
      newPasswordError = '';
      confirmPasswordError = '';
    });

    if (oldPassController.text.isEmpty) {
      setState(() {
        oldPasswordError = 'Current password is required';
      });
      return;
    }
    if (newPassController.text.isEmpty) {
      setState(() {
        newPasswordError = 'New password is required';
      });
      return;
    }
    if (confirmPassController.text.isEmpty) {
      setState(() {
        confirmPasswordError = 'Please confirm your new password';
      });
      return;
    }
    if (newPassController.text != confirmPassController.text) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!, password: oldPassController.text);

      await user.reauthenticateWithCredential(credential);
      await AuthService()
          .updateUserPassword(newPassword: newPassController.text);

      await Dialogs(context).showAnimatedDialog(
        title: AppLocalizations(context).of("password_manager"),
        content: AppLocalizations(context).of("password_change_success"),
      );
      clearFields();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'wrong-password') {
        setState(() {
          oldPasswordError = 'Old password is incorrect';
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          newPasswordError = 'New password is too weak';
        });
      } else if (e.code == 'invalid-credential') {
        setState(() {
          oldPasswordError = 'Invalid password';
        });
      } else {
        await Dialogs(context)
            .showErrorDialog(message: e.message ?? 'An error occurred');
      }
    }
  }

  void clearFields() {
    oldPassController.clear();
    newPassController.clear();
    confirmPassController.clear();
  }
}
