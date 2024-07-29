import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/widgets/label_and_textfield.dart';
import 'package:clothing_store_app/widgets/loading.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/widgets/sign_in_method.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
                style: TextStyles(context).getTitleStyle(),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations(context).of("welcome"),
                style: TextStyles(context).getDescriptionStyle(),
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
              ),
              const Padding(padding: EdgeInsets.all(2)),
              CommonButton(
                onTap: signIn,
                buttonText: "sign_in",
                radius: 35,
                width: MediaQuery.of(context).size.width - 60,
              ),
              const Padding(padding: EdgeInsets.all(18)),
              Row(
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
              const Padding(padding: EdgeInsets.all(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  signInMethod(Localfiles.googleIcon),
                  const Padding(padding: EdgeInsets.all(8)),
                  signInMethod(Localfiles.facebookIcon),
                ],
              ),
              const Padding(padding: EdgeInsets.all(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations(context).of("no_account"),
                      style: TextStyles(context).getRegularStyle()),
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
        } else if (emailController.text.isEmpty) {
          emailError = AppLocalizations(context).of("login_e1");
        } else if (passController.text.isEmpty) {
          passwordError = AppLocalizations(context).of("login_e2");
        } else if (value.toString() ==
            '[firebase_auth/invalid-email] The email address is badly formatted.') {
          emailError = AppLocalizations(context).of("login_e3");
        } else if (value.toString() ==
            '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.') {
          passwordError = AppLocalizations(context).of("login_e4");
        } else if (value.toString() ==
            '[firebase_auth/too-many-requests] Access to this account has been temporarily disabled due to many failed login attempts.') {
          emailError = AppLocalizations(context).of("login_e5");
        } else {
          res = true;
        }
      },
    );
    return res;
  }

  Future signIn() async {
    loading(context);
    bool loginStatus =
        await checkSignIn(emailController.text.trim(), passController.text);
    setState(() {});
    Navigator.pop(context);
    if (loginStatus == true) {
      //push HomePage}
    }
  }
}
