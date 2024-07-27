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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool isNotShowingPass;
  late TextEditingController emailController;
  late TextEditingController passController;
  late String error;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    error = '';
    isNotShowingPass = false;
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
        child: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(28)),
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
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("email"),
                      style: TextStyles(context).getRegularStyle(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: CommonTextField(
                    textEditingController: emailController,
                    contentPadding: const EdgeInsets.all(14),
                    hintTextStyle: TextStyles(context).getDescriptionStyle(),
                    focusColor: const Color.fromARGB(255, 112, 79, 56),
                    hintText: 'example@gmail.com',
                    textFieldPadding: const EdgeInsets.all(0)),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations(context).of("password"),
                      style: TextStyles(context).getRegularStyle(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              Stack(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: CommonTextField(
                    isObscureText: !isNotShowingPass,
                    textEditingController: passController,
                    contentPadding: const EdgeInsets.all(14),
                    hintTextStyle: TextStyles(context).getDescriptionStyle(),
                    focusColor: const Color.fromARGB(255, 112, 79, 56),
                    hintText: '***********',
                    textFieldPadding: const EdgeInsets.all(0),
                    suffixIconData: Icons.visibility,
                    selectedIconData: Icons.visibility_off,
                  ),
                ),
              ]),
              const Padding(padding: EdgeInsets.all(2)),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
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

  Widget signInMethod(String imageLink) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        child: CircleAvatar(
          radius: 39,
          backgroundColor: Colors.white,
          child: Image.asset(
            imageLink,
            width: 36,
            height: 36,
          ),
        ),
      ),
    );
  }

  Future<bool> checkSignIn(String mail, String pass) async {
    bool res = true;
    await AuthService()
        .signInWithEmailAndPassword(email: mail, password: pass)
        .then(
      (value) {
        if (value == null) {
          setState(() {
            error = AppLocalizations(context).of("login_e6");
          });
          res = false;
        } else if (emailController.text.isEmpty) {
          setState(() {
            error = AppLocalizations(context).of("login_e1");
          });
          res = false;
        } else if (passController.text.isEmpty) {
          setState(() {
            error = AppLocalizations(context).of("login_e2");
          });
          res = false;
        } else if (value.toString() ==
            '[firebase_auth/invalid-email] The email address is badly formatted.') {
          setState(() {
            error = AppLocalizations(context).of("login_e3");
          });
          res = false;
        } else if (value.toString() ==
            '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.') {
          setState(() {
            error = AppLocalizations(context).of("login_e4");
          });
          res = false;
        } else if (value.toString() ==
            '[firebase_auth/too-many-requests] Access to this account has been temporarily disabled due to many failed login attempts.') {
          setState(() {
            error = AppLocalizations(context).of("login_e5");
          });
          res = false;
        }
      },
    );
    return res;
  }

  Future signIn() async {
    loading(context);
    bool loginStatus =
        await checkSignIn(emailController.text.trim(), passController.text);
    Navigator.pop(context);
    if (loginStatus == true) {
      //push HomePage}
    }
  }
}
