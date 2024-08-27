import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/label_and_textfield.dart';
import 'package:clothing_store_app/widgets/sign_in_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../languages/appLocalizations.dart';
import '../../providers/sign_up_provider.dart';
import '../../widgets/common_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                24, AppBar().preferredSize.height, 24, 10),
            child: Column(
              children: [
                Text(
                  AppLocalizations(context).of("createAccount"),
                  style: TextStyles(context).getLargerHeaderStyle(false),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Text(
                  AppLocalizations(context).of("createAccountDescript"),
                  style: TextStyles(context)
                      .getInterDescriptionStyle(false, false),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                Consumer<SignUpNotifier>(
                  builder: (context, notifier, child) {
                    return Form(
                      key: notifier.formKey,
                      child: Column(
                        children: [
                          labelAndTextField(
                              context: context,
                              label: "email",
                              hintText: 'example@gmail.com',
                              controller: notifier.emailController,
                              errorText: notifier.emailError),
                          labelAndTextField(
                              context: context,
                              label: "password",
                              hintText: '***********',
                              controller: notifier.passwordController,
                              errorText: notifier.passwordError,
                              suffixIconData: Icons.visibility_off,
                              selectedIconData: Icons.visibility,
                              isObscured: true),
                          labelAndTextField(
                              context: context,
                              label: "password",
                              hintText: '***********',
                              controller: notifier.confirmPassController,
                              errorText: notifier.confirmPassError,
                              suffixIconData: Icons.visibility_off,
                              selectedIconData: Icons.visibility,
                              isObscured: true),
                        ],
                      ),
                    );
                  },
                ),
                Consumer<SignUpNotifier>(
                  builder: (context, notifier, child) {
                    return Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: notifier.isAgreed,
                            onChanged: (value) {
                              notifier
                                  .setAgreeTermsAndCondition(value ?? false);
                            },
                            checkColor: AppTheme.backgroundColor,
                            activeColor: AppTheme.brownColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: AppLocalizations(context).of("agree_with"),
                              style: TextStyles(context)
                                  .getInterDescriptionStyle(false, false)),
                          TextSpan(
                              text: AppLocalizations(context)
                                  .of("terms_and_condition"),
                              style: TextStyles(context)
                                  .getInterDescriptionStyle(true, true)),
                        ])),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                Consumer<SignUpNotifier>(
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
                const SizedBox(
                  height: 16.0,
                ),
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
                        style: TextStyles(context)
                            .getInterDescriptionStyle(false, false),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    signInMethod(Localfiles.googleIcon, context),
                    const Padding(padding: EdgeInsets.all(8)),
                    signInMethod(Localfiles.facebookIcon, context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations(context).of("alreadyHaveAccount"),
                      style: TextStyles(context)
                          .getInterDescriptionStyle(false, false),
                    ),
                    TextButton(
                      onPressed: () {
                        onTap();
                      },
                      style: TextButton.styleFrom(
                        //overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        AppLocalizations(context).of("signIn"),
                        style: TextStyles(context)
                            .getInterDescriptionStyle(true, true),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
