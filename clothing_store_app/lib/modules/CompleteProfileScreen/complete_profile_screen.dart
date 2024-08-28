import 'dart:io';
import 'dart:typed_data';
import 'package:clothing_store_app/providers/complete_profile_provider.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/label_and_textfield.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../languages/appLocalizations.dart';
import '../../providers/set_image_provider.dart';
import '../../services/database/user_information.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar_view.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_dialogs.dart';

// ignore: must_be_immutable
class CompleteProfileScreen extends StatelessWidget {
  Uint8List? image;
  CompleteProfileScreen({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompleteProfileNotifier>(
      builder: (context, profileProvider, _) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Appbar
                  Align(
                    alignment: Alignment.topLeft,
                    child: CommonAppBarView(
                      topPadding: 0.0,
                      iconData: Iconsax.arrow_left,
                      onBackClick: () {
                        Navigator.pop(context);
                      },
                      iconSize: 20,
                      iconColor: AppTheme.primaryTextColor,
                    ),
                  ),
                  //Title + Decription
                  Text(
                    AppLocalizations(context).of("complete_your_profile"),
                    style: TextStyles(context).getLargerHeaderStyle(false),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      AppLocalizations(context)
                          .of("complete_your_profile_descript"),
                      style: TextStyles(context)
                          .getInterDescriptionStyle(false, false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  //Profile picture
                  Stack(
                    children: [
                      Consumer<PickImageProvider>(
                        builder: (context, pickImageProvider, _) {
                          image = pickImageProvider.selectedImageBytes;
                          if (pickImageProvider.selectedImage.isEmpty) {
                            return const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage(Localfiles.defaultAvatar));
                          } else {
                            return CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                    File(pickImageProvider.selectedImage)));
                          }
                        },
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: TapEffect(
                            onClick: () {
                              Dialogs(context).showAnimatedImagePickerDialog();
                            },
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors.brown,
                                ),
                                child: const Icon(
                                  Iconsax.image,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  //Information fields
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: labelAndTextField(
                            context: context,
                            label: "name",
                            hintText: AppLocalizations(context).of("John Doe"),
                            controller: profileProvider.nameController,
                            errorText: profileProvider.nameError),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations(context).of("phoneNumber"),
                              style:
                                  TextStyles(context).getLabelLargeStyle(false),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            IntlPhoneField(
                                controller: profileProvider.phoneController,
                                initialCountryCode: '+84',
                                disableLengthCheck: true,
                                decoration: InputDecoration(
                                  error: profileProvider.phoneError.isNotEmpty
                                      ? Text(
                                          profileProvider.phoneError,
                                          style: TextStyles(context)
                                              .getSmallStyle()
                                              .copyWith(
                                                color: AppTheme.redErrorColor,
                                              ),
                                        )
                                      : null,
                                  hintText: AppLocalizations(context)
                                      .of("enterPhoneNumber"),
                                  hintStyle: TextStyles(context)
                                      .getLabelLargeStyle(true),
                                  contentPadding: const EdgeInsets.all(16.0),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(40.0)),
                                    borderSide: BorderSide(
                                      color: AppTheme.brownButtonColor,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(40.0)),
                                    borderSide: BorderSide(
                                      color: AppTheme.brownButtonColor,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations(context).of("gender"),
                              style:
                                  TextStyles(context).getLabelLargeStyle(false),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            DropdownButtonFormField(
                              focusColor: AppTheme.brownButtonColor,
                              value: null,
                              hint: Text(
                                AppLocalizations(context).of("select"),
                                style: TextStyles(context)
                                    .getLabelLargeStyle(true),
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16.0),
                                error: profileProvider.genderError.isNotEmpty
                                    ? Text(
                                        profileProvider.genderError,
                                        style: TextStyles(context)
                                            .getSmallStyle()
                                            .copyWith(
                                              color: AppTheme.redErrorColor,
                                            ),
                                      )
                                    : null,
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40.0)),
                                  borderSide: BorderSide(
                                    color: AppTheme.brownButtonColor,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40.0)),
                                  borderSide: BorderSide(
                                    color: AppTheme.brownButtonColor,
                                  ),
                                ),
                              ),
                              items: List<DropdownMenuItem<int>>.generate(
                                profileProvider.genders.length,
                                (index) => DropdownMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    AppLocalizations(context)
                                        .of(profileProvider.genders[index]),
                                    style: TextStyles(context)
                                        .getLabelLargeStyle(false),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                profileProvider.setSelectedGender(value!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  //Complete Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CommonButton(
                      onTap: () async {
                        if (profileProvider.validateFields(context)) {
                          Dialogs(context).showLoadingDialog();
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          UserInformationService().setUserInformation(
                            name: profileProvider.nameController.text.trim(),
                            phone: profileProvider.phoneController.text.trim(),
                            fileImageName: uid,
                            image: image,
                          );
                          await Future.delayed(
                              const Duration(milliseconds: 2000));
                          Navigator.pop(context);
                          Dialogs(context).showAnimatedDialog(
                              title: AppLocalizations(context)
                                  .of("complete_your_profile"),
                              content: 'Successfully complete your profile!');
                          //MOVE TO LOCATION PAGE
                        }
                      },
                      radius: 30.0,
                      backgroundColor: AppTheme.brownButtonColor,
                      buttonTextWidget: Text(
                        AppLocalizations(context).of("complete_profile"),
                        style: TextStyles(context).getButtonTextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
