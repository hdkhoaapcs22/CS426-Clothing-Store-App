import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../providers/set_image_provider.dart';
import '../utils/text_styles.dart';
import '../utils/themes.dart';

class Dialogs {
  final BuildContext context;
  Dialogs(this.context);

  Future<dynamic> showLoadingDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        double lottieSize = MediaQuery.of(context).size.width * 0.2;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset(
              Localfiles.loading,
              width: lottieSize,
            ));
      },
    );
  }

  Future<void> showErrorDialog({required String message}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Error"),
              scrollable: true,
              content: SingleChildScrollView(
                child: Text(message),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
                )
              ]);
        });
  }

  Future<void> showAnimatedDialog(
      {required String title, required String content}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (content, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                title: Text(
                  title,
                  style: TextStyles(context)
                      .getButtonTextStyle()
                      .copyWith(color: AppTheme.primaryTextColor),
                ),
                content: Text(
                  content,
                  style: TextStyles(context).getLabelLargeStyle(false).copyWith(
                      color: AppTheme.redErrorColor,
                      fontWeight: FontWeight.w400),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none),
              ),
            ),
          );
        });
  }

  Future<void> showAnimatedImagePickerDialog() {
    final size = MediaQuery.of(context).size;
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (content, animation1, animation2) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
            child: FadeTransition(
                opacity:
                    Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
                child: AlertDialog(
                  title: Text(
                    AppLocalizations(context).of("upload_profile_picture"),
                    style: TextStyles(context)
                        .getButtonTextStyle()
                        .copyWith(color: AppTheme.primaryTextColor),
                  ),
                  content: SizedBox(
                    height: size.height / 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CommonButton(
                            onTap: () async {
                              final pickImageProvider =
                                  Provider.of<PickImageProvider>(context,
                                      listen: false);
                              await pickImageProvider.pickImageFromGallery();
                            },
                            backgroundColor: AppTheme.brownButtonColor,
                            radius: 30,
                            height: size.height / 18,
                            icon: Iconsax.gallery_add,
                            buttonText: "from_library",
                            fontSize: 16,
                            textColor: AppTheme.backgroundColor,),
                        CommonButton(
                            onTap: () async {
                              final pickImageProvider =
                                  Provider.of<PickImageProvider>(context,
                                      listen: false);
                              await pickImageProvider.takePhoto();
                            },
                            radius: 30,
                            height: size.height / 18,
                            backgroundColor: AppTheme.brownButtonColor,
                            icon: Iconsax.camera,
                            buttonText: "take_photo",
                            fontSize: 16,
                            textColor: AppTheme.backgroundColor,)
                      ],
                    ),
                  ),
                )),
          );
        },
        transitionBuilder: (context, a1, a2, widget) {
          return widget;
        });
  }

  Future<void> showAnimatedDialogWithInputField({
    required BuildContext context,
    required String title,
    required String hintText,
    required Function(String) onSave,
  }) {

    final TextEditingController _controller = TextEditingController();

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
              title: Text(
                title,
                style: TextStyles(context)
                    .getButtonTextStyle()
                    .copyWith(color: AppTheme.brownButtonColor, fontSize: 16),
              ),
              content: SizedBox(
                height: 50,
                child: CommonTextField(
                  textEditingController: _controller,
                  textFieldPadding: EdgeInsets.zero,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: hintText,
                  hintTextStyle: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14),
                  focusColor: AppTheme.brownButtonColor,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations(context).of("cancel"), style: TextStyles(context).getLabelLargeStyle(false),),
                ),
                TextButton(
                  onPressed: () {
                    onSave(_controller.text);
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations(context).of("save"), style: TextStyles(context).getLabelLargeStyle(false),),
                ),
              ],
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }


Future<void> showAnimatedDialogWithPhoneField({
    required BuildContext context,
    required String title,
    required Function(String) onSave,
    required String hintText,
    required Function(PhoneNumber) onChanged,
  }) {
    String phoneNumber = '';
    final TextEditingController _controller = TextEditingController();
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
              title: Text(
                title,
                style: TextStyles(context)
                    .getButtonTextStyle()
                    .copyWith(color: AppTheme.brownButtonColor, fontSize: 16),
              ),
              content: SizedBox(
                height: 50,
                child: IntlPhoneField(
                  controller: _controller,
                  initialCountryCode: 'VN',
                  disableLengthCheck: true,
                  onChanged: (phone) {
                    String countryCode = phone.countryCode;
                    phoneNumber = '(${countryCode}) ${_controller.text.trim()}';
                  },
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyles(context).getLabelLargeStyle(true),
                    contentPadding: const EdgeInsets.all(16.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(
                        color: AppTheme.brownButtonColor,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(
                        color: AppTheme.brownButtonColor,
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations(context).of("cancel"),
                    style: TextStyles(context).getLabelLargeStyle(false),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onSave(phoneNumber);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations(context).of("save"),
                    style: TextStyles(context).getLabelLargeStyle(false),
                  ),
                ),
              ],
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }

}
