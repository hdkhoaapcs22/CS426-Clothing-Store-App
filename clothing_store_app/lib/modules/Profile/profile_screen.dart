import 'dart:io';
import 'dart:typed_data';

import 'package:clothing_store_app/common/helper_funtion.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/Profile/profile_service_card.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/set_image_provider.dart';
import '../../services/auth/auth_service.dart';
import '../../services/database/user_information.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_dialogs.dart';
import '../../widgets/tap_effect.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreen({super.key, required this.animationController});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  String? image;
  String username = '';
  String userPhoneNum = '';
  final userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
  final UserInformationService userInformation = UserInformationService();
  List<String> listOfProfileServices = [
    'your_profile',
    'payment_methods',
    'settings',
    'help_center',
    'privacy_policy',
    'invite_friends',
    'log_out'
  ];

  @override
  void initState(){
    Future.delayed(Duration.zero, () {
      Provider.of<PickImageProvider>(context, listen: false).reset();
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    return StreamBuilder(
        stream: userInformation.getUserInfomationStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Lottie.asset(
                  Localfiles.loading,
                  width: lottieSize,
                ));
          } else if (!snapshot.hasData || snapshot.data?.data() == null) {
            return const Center(child: Text('User data not found'));
          }

          Map<String, dynamic>? userData = snapshot.data!.data();
          image = userData?['imageUrl'] ?? '';
          username = userData?['name'] ?? '';
          userPhoneNum = userData?['phone'] ?? '';
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //App Bar
                  CommonDetailedAppBarView(
                    title: AppLocalizations(context).of("profile"),
                    prefixIconData: Iconsax.arrow_left,
                    onPrefixIconClick: () {
                      Navigator.pop(context);
                    },
                    iconColor: AppTheme.primaryTextColor,
                    backgroundColor: AppTheme.backgroundColor,
                  ),
                  //Profile Picture
                  Stack(
                    children: [
                      Consumer<PickImageProvider>(
                          builder: (context, pickImageProvider, _) {
                        if (pickImageProvider.selectedImage.isNotEmpty && !pickImageProvider.isUploaded) {
                          uploadImageAndReturnAvatar(pickImageProvider).then((_){
                            pickImageProvider.updateUploadedPic();
                          });
                          return CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                  File(pickImageProvider.selectedImage)));
                        } else {
                          if (image!.isEmpty) {
                            return const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage(Localfiles.defaultAvatar));
                          } else {
                            print('Get image from firebase');
                            return CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(image!));
                          }
                        }
                      }),
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
                  //Username
                  Text(
                    username,
                    style: TextStyles(context)
                        .getLargerHeaderStyle(false)
                        .copyWith(fontSize: 20),
                  ),
                  //List of profile services
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listOfProfileServices.length,
                      itemBuilder: (context, index) {
                        return ProfileServiceCard(
                          icon: HelperFunction.getIconForProfileServices(index),
                          title: listOfProfileServices[index],
                          onClick: getServicesFunction(context, index),
                          isLastService:
                              index == listOfProfileServices.length - 1,
                        );
                      })
                ],
              ),
            ),
          );
        });
  }

  Future<void> uploadImageAndReturnAvatar(PickImageProvider pickImageProvider) async {
  try {
    Uint8List? imageBytes = pickImageProvider.selectedImageBytes;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    String imageUrl = await userInformation.uploadImageToStorage(uid, imageBytes!);

    await FirebaseFirestore.instance.collection('User').doc(uid).update({
      'imageUrl': imageUrl,
    });
  } catch (e) {
    print('Failed to upload image: $e');
  }
}

  VoidCallback getServicesFunction(BuildContext context, int index) {
    switch (index) {
      case 0:
        return () {
          NavigationServices(context).pushUpdateProfileScreen(username, userEmail, userPhoneNum);
        };
      case 1:
        return () {
          NavigationServices(context).pushPaymentMethodScreen();
        };
      case 2:
        return () {
          NavigationServices(context).pushSettingScreen();
        };
      case 3:
        return () {
          NavigationServices(context).pushHelpCenterScreen();
        };
      case 4:
        return () {
          NavigationServices(context).pushPrivacyPolicyScreen();
        };
      case 5:
        return () {
          NavigationServices(context).pushInviteFriendsScreen();
        };
      case 6:
        return () async {
          await logOutBottomSheet(context);
        };
      default:
        return () {};
    }
  }
}

Future<dynamic> logOutBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context, 
    builder: (context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  AppLocalizations(context).of("log_out"),
                  style: TextStyles(context)
                      .getLabelLargeStyle(false)
                      .copyWith(fontSize: 18),
                ),
            ),
            Divider(
              indent: 32,
              endIndent: 32,
              thickness: 0.5,
              color: AppTheme.secondaryTextColor.withAlpha(200),
            ),
            Text(
                AppLocalizations(context).of("are_you_sure_to_log_out"),
                style:
                    TextStyles(context).getInterDescriptionStyle(false, false),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      backgroundColor: AppTheme.backgroundColor,
                      buttonText: "cancel",
                      textColor: AppTheme.brownButtonColor,
                      bordeColor: AppTheme.brownButtonColor,
                      fontSize: 16,
                      radius: 30,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: CommonButton(
                      backgroundColor: AppTheme.brownButtonColor,
                      buttonText: "yes_logout",
                      textColor: AppTheme.backgroundColor,
                      fontSize: 16,
                      radius: 30,
                      onTap: () async {
                        final auth = AuthService();
                        await auth.signOutAccount();
                        NavigationServices(context).pushAndRemoveUntilLoginScreen();
                      },
                    )
                  )
                ],
              ),
            )
          ],),
      );
    }
  );
}