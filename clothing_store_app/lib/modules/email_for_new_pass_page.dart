import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/utils/loading.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailForNewPassPage extends StatefulWidget {
  const EmailForNewPassPage({super.key});

  @override
  State<EmailForNewPassPage> createState() => _EmailForNewPassPageState();
}

class _EmailForNewPassPageState extends State<EmailForNewPassPage> {
  TextEditingController emailController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    TextStyles textStyle = TextStyles(context);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(28)),
            SizedBox(
              width: 400,
              child: Row(
                children: [
                  Stack(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.grey)),
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 19,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: IgnorePointer(
                            child: Image.asset(
                              Localfiles.leftArrow,
                              width: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  const Spacer(),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Text(
              AppLocalizations(context).of("email"),
              style: textStyle.getTitleStyle(),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Text(
              AppLocalizations(context).of("pls_enter_email"),
              style: textStyle.getDescriptionStyle(),
            ),
            Text(
              AppLocalizations(context).of("ex_email"),
              style: const TextStyle(
                  color: Color.fromARGB(255, 112, 79, 56),
                  fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(12)),
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
            const Padding(padding: EdgeInsets.all(4)),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const Padding(padding: EdgeInsets.all(2)),
            SizedBox(
                width: 380,
                child: CommonButton(
                  onTap: sendPassResetEmail,
                  buttonText: "send_verification_code",
                  radius: 35,
                )),
          ],
        ),
      ),
    );
  }

  Future sendPassResetEmail() async {
    loading(context);
    await AuthService().sendPassResetLink(emailController.text).then((value) {
      if (value is FirebaseAuthException) {
        setState(() {
          error = AppLocalizations(context).of("login_e3");
        });
      } else {
        setState(() {
          error = AppLocalizations(context).of("email_sent");
        });
      }
    });
    Navigator.pop(context);
  }
}
