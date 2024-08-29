import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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

  Future<void> showAlertDialog({required String content}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.brownButtonColor,
                    ),
                    child: Text(
                      'Close',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(color: AppTheme.backgroundColor),
                    ))
              ],
              contentPadding: const EdgeInsets.all(20.0),
              content: Text(
                content,
                style: TextStyles(context).getLabelLargeStyle(false).copyWith(
                    color: AppTheme.redErrorColor, fontWeight: FontWeight.w400),
              ),
            ));
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
}
