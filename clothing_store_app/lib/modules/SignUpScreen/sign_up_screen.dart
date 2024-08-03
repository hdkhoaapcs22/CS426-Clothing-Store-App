import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../languages/appLocalizations.dart';
import '../../providers/sign_up_provider.dart';
import '../../utils/localfiles.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_dialogs.dart';
import '../../widgets/text_field_with_header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  AppLocalizations(context).of("createAccount"),
                  style: TextStyles(context).getLargerHeaderStyle(false),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  AppLocalizations(context).of("createAccountDescript"),
                  style: TextStyles(context).getInterDescriptionStyle(false, false),
                  textAlign: TextAlign.center,
                ),
              ),
              Consumer<SignUpNotifier>(
                builder: (context, notifier, child) {
                  return Form(
                    key: notifier.formKey,
                    child: Column(
                      children: [
                        TextFieldWithHeader(
                          controller: notifier.nameController,
                          errorMessage: notifier.nameError,
                          header: AppLocalizations(context).of("name"),
                          hintText: AppLocalizations(context).of("John Doe"),
                          isPassword: false,
                        ),
                        TextFieldWithHeader(
                          controller: notifier.emailController,
                          errorMessage: notifier.emailError,
                          header: AppLocalizations(context).of("email"),
                          hintText:
                              AppLocalizations(context).of("example@gmail.com"),
                          isPassword: false,
                        ),
                        TextFieldWithHeader(
                          controller: notifier.passwordController,
                          errorMessage: notifier.passwordError,
                          header: AppLocalizations(context).of("password"),
                          hintText: "********",
                          isPassword: true,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Consumer<SignUpNotifier>(
                  builder: (context, notifier, child) {
                    return Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: notifier.isAgreed,
                            onChanged: (value) {
                              notifier.setAgree(value ?? false);
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: AppLocalizations(context).of("agree_with"),
                              style: TextStyles(context).getInterDescriptionStyle(false, false)),
                          TextSpan(
                              text: AppLocalizations(context).of("terms_and_condition"),
                              style: TextStyles(context).getInterDescriptionStyle(true, true)),
                        ])),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Consumer<SignUpNotifier>(
                  builder: (context, notifier, child) {
                    return CommonButton(
                      onTap: () => notifier.registerAccount(context),
                      radius: 30.0,
                      backgroundColor: AppTheme.brownButtonColor,
                      buttonTextWidget: Text(
                        AppLocalizations(context).of("signUp"),
                        style: TextStyles(context).getButtonTextStyle(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: AppTheme.secondaryTextColor,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                    )),
                    Text(
                      AppLocalizations(context).of("orSignUpWith"),
                      style: TextStyles(context).getInterDescriptionStyle(false, false),
                    ),
                    Flexible(
                      child: Divider(
                        color: AppTheme.secondaryTextColor,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.secondaryTextColor),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () async {
                          String? userId = await AuthService().signInWithGoogle();
                          if (userId != null) {
                            await Dialogs(context).showAnimatedDialog(
                                title: AppLocalizations(context).of("success"),
                                content: AppLocalizations(context).of("register_successfully"));
                            NavigationServices(context).pushCompleteProfileScreen();
                          }
                        },
                        icon: const Image(
                          width: 20,
                          height: 20,
                          image: AssetImage(Localfiles.googleLogo),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.secondaryTextColor),
                        borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {
                          // String? userId =
                          //     await AuthService().signInWithFacebook();
                          // if (userId != null) {
                          //   await Dialogs(context).showAnimatedDialog(
                          //       title: AppLocalizations(context).of("signUp"),
                          //       content: AppLocalizations(context)
                          //           .of("register_successfully"));
                          //   NavigationServices(context)
                          //       .pushCompleteProfileScreen();
                          // }
                        },
                        icon: const Image(
                          width: 20,
                          height: 20,
                          image: AssetImage(Localfiles.facebookLogo),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations(context).of("alreadyHaveAccount"),
                    style: TextStyles(context).getInterDescriptionStyle(false, false),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationServices(context).pushLoginScreen();
                    },
                    child: Text(
                      AppLocalizations(context).of("signIn"),
                      style: TextStyles(context).getInterDescriptionStyle(true, true),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}