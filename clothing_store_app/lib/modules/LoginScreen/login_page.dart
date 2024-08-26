import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:clothing_store_app/widgets/label_and_textfield.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/widgets/sign_in_method.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passController;
  late String passwordError, emailError;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    passwordError = '';
    emailError = '';
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              24, AppBar().preferredSize.height + 30, 24, 10),
          child: Column(
            children: [
              Text(
                AppLocalizations(context).of("login"),
                style: TextStyles(context).getLargerHeaderStyle(false),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations(context).of("welcome"),
                style:
                    TextStyles(context).getInterDescriptionStyle(false, false),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(24)),
              labelAndTextField(
                  context: context,
                  label: "email",
                  hintText: 'example@gmail.com',
                  controller: emailController,
                  errorText: emailError),
              labelAndTextField(
                  context: context,
                  label: "password",
                  hintText: '***********',
                  controller: passController,
                  errorText: passwordError,
                  suffixIconData: Icons.visibility_off,
                  selectedIconData: Icons.visibility,
                  isObscured: true),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {
                      NavigationServices(context).pushForgotPassPage();
                    },
                    style: TextButton.styleFrom(
                      //overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      AppLocalizations(context).of("forget_pass"),
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 112, 79, 56),
                          fontSize: 16),
                    )),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              CommonButton(
                onTap: signIn,
                radius: 30.0,
                backgroundColor: AppTheme.brownButtonColor,
                buttonTextWidget: Text(
                  AppLocalizations(context).of("sign_in"),
                  style: TextStyles(context).getButtonTextStyle(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(18)),
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
                      AppLocalizations(context).of("other_sign_in"),
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
                    AppLocalizations(context).of("no_account"),
                    style: TextStyles(context)
                        .getInterDescriptionStyle(false, false),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onTap();
                    },
                    style: TextButton.styleFrom(
                     // overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      AppLocalizations(context).of("sign_up"),
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
    );
  }

  Future<bool> checkSignIn(String mail, String pass) async {
    bool res = false;
    emailError = '';
    passwordError = '';
    await AuthService()
        .signInWithEmailAndPassword(email: mail, password: pass)
        .then(
      (value) {
        if (value == null) {
          emailError = AppLocalizations(context).of("login_e6");
        } else if (mail.isEmpty) {
          emailError = AppLocalizations(context).of("login_e1");
        } else if (pass.isEmpty) {
          passwordError = AppLocalizations(context).of("login_e2");
        } else if (value.toString().contains('invalid-email')) {
          emailError = AppLocalizations(context).of("login_e3");
        } else if (value.toString().contains('invalid-credential')) {
          passwordError = AppLocalizations(context).of("login_e4");
        } else if (value.toString().contains('too-many-requests')) {
          emailError = AppLocalizations(context).of("login_e5");
        } else {
          res = true;
        }
      },
    );
    return res;
  }

  Future signIn() async {
    Dialogs(context).showLoadingDialog();
    bool loginStatus =
        await checkSignIn(emailController.text.trim(), passController.text);
    setState(() {});
    Navigator.pop(context);
    if (loginStatus == true) {
      NavigationServices(context).gotoBottomTapScreen();
    }
  }
}
