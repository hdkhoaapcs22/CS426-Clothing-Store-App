import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/new_password_page.dart';
import 'package:clothing_store_app/modules/verification_page.dart';
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
  bool isShowingPass = false;
  String email = '';
  String pass = '';
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                'Hi! Welcome back, you\'ve been missed',
                style: textStyle.getDescriptionStyle(),
              ),
              const Padding(padding: EdgeInsets.all(24)),
              SizedBox(
                width: 380,
                child: Row(
                  children: [
                    Text(
                      'Email',
                      style: textStyle.getRegularStyle(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              SizedBox(
                width: 380,
                child: CommonTextFieldView(
                    onSubmitted: (value) {
                      updateEmail(value);
                    },
                    contentPadding: const EdgeInsets.all(14),
                    hintTextStyle: textStyle.getDescriptionStyle(),
                    focusColor: Colors.red,
                    hintText: 'example@gmail.com',
                    textFieldPadding: const EdgeInsets.all(0)),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: 380,
                child: Row(
                  children: [
                    Text(
                      'Password',
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
                  child: CommonTextFieldView(
                      onSubmitted: (value) {
                        updatePass(value);
                      },
                      contentPadding: const EdgeInsets.all(14),
                      hintTextStyle: textStyle.getDescriptionStyle(),
                      focusColor: Colors.red,
                      hintText: '***********',
                      textFieldPadding: const EdgeInsets.all(0)),
                ),
                Positioned(
                  top: 10,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowingPass = !isShowingPass;
                      });
                    },
                    child: Image.asset(
                      isShowingPass == false
                          ? 'assets/images/hide_pass_icon.png'
                          : 'assets/images/show_pass_icon.png',
                      width: 40,
                      height: 30,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                width: 380,
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewPasswordPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          overlayColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 112, 79, 56),
                              fontSize: 16),
                        )),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              SizedBox(
                  width: 380,
                  child: CommonButton(
                    onTap: () async {
                      try {
                        String? tmp = await AuthService()
                            .signInWithEmailAndPassword(
                                email: email, password: pass) as String?;

                        if (tmp != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VerificationPage()),
                          );
                        }
                      } catch (e) {}
                    },
                    buttonTextWidget: const Text('Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    radius: 35,
                  )),
              const Padding(padding: EdgeInsets.all(18)),
              const SizedBox(
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100,
                        child:
                            Divider(color: Color.fromARGB(255, 114, 114, 114))),
                    Padding(padding: EdgeInsets.all(2)),
                    Text('Or sign in with',
                        style: TextStyle(
                            color: Color.fromARGB(255, 114, 114, 114),
                            fontSize: 15)),
                    Padding(padding: EdgeInsets.all(2)),
                    SizedBox(
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
                        top: 20,
                        left: 22,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: IgnorePointer(
                            child: Image.asset(
                              'assets/images/apple_icon.png',
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
                              'assets/images/google_icon.png',
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
                              'assets/images/facebook_icon.png',
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
                  Text('Don\'t have an account? ',
                      style: textStyle.getRegularStyle()),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        overlayColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
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

  void updateEmail(String s) {
    email = s;
  }

  void updatePass(String s) {
    pass = s;
  }
}
