import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/utils/loading.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowingPass = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    TextStyles textStyle = TextStyles(context);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(48)),
              Text(
                AppLocalizations(context).of("login"),
                style: textStyle.getTitleStyle(),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations(context).of("welcome"),
                style: textStyle.getDescriptionStyle(),
              ),
              const Padding(padding: EdgeInsets.all(24)),
              SizedBox(
                width: 380,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("email"),
                      style: textStyle.getRegularStyle(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              SizedBox(
                width: 380,
                child: CommonTextField(
                    textEditingController: emailController,
                    contentPadding: const EdgeInsets.all(14),
                    hintTextStyle: textStyle.getDescriptionStyle(),
                    focusColor: const Color.fromARGB(255, 112, 79, 56),
                    hintText: 'example@gmail.com',
                    textFieldPadding: const EdgeInsets.all(0)),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: 380,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("password"),
                      style: textStyle.getRegularStyle(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              Stack(children: [
                SizedBox(
                  width: 380,
                  child: CommonTextField(
                      isObscureText: isShowingPass,
                      textEditingController: passController,
                      contentPadding: const EdgeInsets.all(14),
                      hintTextStyle: textStyle.getDescriptionStyle(),
                      focusColor: const Color.fromARGB(255, 112, 79, 56),
                      hintText: '***********',
                      textFieldPadding: const EdgeInsets.all(0)),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowingPass = !isShowingPass;
                        });
                      },
                      child: Icon(isShowingPass == false
                          ? Iconsax.eye
                          : Iconsax.eye_slash)),
                ),
              ]),
              const Padding(padding: EdgeInsets.all(2)),
              SizedBox(
                width: 380,
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          NavigationServices(context).pushEmailForNewPassPage();
                        },
                        style: TextButton.styleFrom(
                          overlayColor: Colors.transparent,
                        ),
                        child: Text(
                          AppLocalizations(context).of("forget_pass"),
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 112, 79, 56),
                              fontSize: 16),
                        )),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              SizedBox(
                  width: 380,
                  child: CommonButton(
                    onTap: signIn,
                    buttonText: "sign_in",
                    radius: 35,
                  )),
              const Padding(padding: EdgeInsets.all(18)),
              SizedBox(
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: 100,
                        child:
                            Divider(color: Color.fromARGB(255, 114, 114, 114))),
                    const Padding(padding: EdgeInsets.all(2)),
                    Text(AppLocalizations(context).of("other_sign_in"),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 114, 114, 114),
                            fontSize: 15)),
                    const Padding(padding: EdgeInsets.all(2)),
                    const SizedBox(
                        width: 100,
                        child:
                            Divider(color: Color.fromARGB(255, 114, 114, 114))),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.grey)),
                        child: const SizedBox(
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Positioned(
                        top: 22,
                        left: 22,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: IgnorePointer(
                            child: Image.asset(
                              Localfiles.googleIcon,
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Stack(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.grey)),
                        child: const SizedBox(
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Positioned(
                        top: 22,
                        left: 22,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: IgnorePointer(
                            child: Image.asset(
                              Localfiles.facebookIcon,
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations(context).of("no_account"),
                      style: textStyle.getRegularStyle()),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        AppLocalizations(context).of("sign_up"),
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 112, 79, 56),
                            fontSize: 16),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    loading(context);
    await AuthService()
        .signInWithEmailAndPassword(
            email: emailController.text.trim(), password: passController.text)
        .then((value) {
      if (emailController.text.isEmpty) {
        setState(() {
          error = AppLocalizations(context).of("login_e1");
        });
        return;
      } else if (passController.text.isEmpty) {
        setState(() {
          error = AppLocalizations(context).of("login_e2");
        });
        return;
      }
      if (value.toString() ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        setState(() {
          error = AppLocalizations(context).of("login_e3");
        });
        return;
      } else if (value.toString() ==
          '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.') {
        setState(() {
          error = AppLocalizations(context).of("login_e4");
        });
        return;
      } else if (value.toString() ==
          '[firebase_auth/too-many-requests] Access to this account has been temporarily disabled due to many failed login attempts.') {
        setState(() {
          error = AppLocalizations(context).of("login_e5");
        });
        return;
      }
    });
    Navigator.pop(context);
  }
}
