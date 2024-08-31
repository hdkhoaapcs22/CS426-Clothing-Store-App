import 'package:clothing_store_app/modules/Profile/UpdateProfile/update_profile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../languages/appLocalizations.dart';
import '../../../services/database/user_information.dart';
import '../../../utils/themes.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_detailed_app_bar.dart';
import '../../../widgets/common_dialogs.dart';

// ignore: must_be_immutable
class UpdateProfileScreen extends StatefulWidget {
  String username, email, phoneNumber;

  UpdateProfileScreen({
    super.key,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> with TickerProviderStateMixin {
  final UserInformationService userInformation = UserInformationService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("your_profile"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            UpdateProfileWidget(
              title: 'Email',
              content: widget.email,
              onClick: () async {
                Dialogs(context)
                    .showAlertDialog(content: 'Cannot change email address');
              },
            ),
            UpdateProfileWidget(
              title: 'Username',
              content: widget.username,
              onClick: () async {
                Dialogs(context).showAnimatedDialogWithInputField(
                    context: context,
                    title: 'Update Username',
                    hintText: 'Change your name?',
                    onSave: (value) {
                      setState(() {
                        widget.username = value;
                      });
                    });
              },
            ),
            UpdateProfileWidget(
              title: 'Phone Number',
              content: widget.phoneNumber,
              onClick: () {
                Dialogs(context).showAnimatedDialogWithPhoneField(
                  context: context,
                  title: 'Enter Phone Number',
                  hintText: AppLocalizations(context).of("enterPhoneNumber"),
                  onChanged: (phone) {},
                  onSave: (value) {
                    setState(() {
                      widget.phoneNumber = value;
                    });
                  },
                );
              },
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
                handleUpdateProfile();
              },
              buttonText: 'update_profile',
              radius: 40,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleUpdateProfile() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      
      await UserInformationService().updateUserInformation(
          name: widget.username, phone: widget.phoneNumber, fileImageName: uid);
      
      await Dialogs(context).showAnimatedDialog(
        title: AppLocalizations(context).of("update_profile"), 
        content: AppLocalizations(context).of("update_profile_successfully")
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }
}