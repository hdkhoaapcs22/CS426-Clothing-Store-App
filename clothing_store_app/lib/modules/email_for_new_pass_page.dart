import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/widgets/label_and_textfield.dart';
import 'package:clothing_store_app/widgets/loading.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';

class EmailForNewPassPage extends StatefulWidget {
  const EmailForNewPassPage({super.key});

  @override
  State<EmailForNewPassPage> createState() => _EmailForNewPassPageState();
}

class _EmailForNewPassPageState extends State<EmailForNewPassPage> {
  late TextEditingController emailController;
  late String error;

  @override
  void initState() {
    emailController = TextEditingController();
    error = '';
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            Localfiles.leftArrow,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations(context).of("email"),
                style: TextStyles(context).getTitleStyle(),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations(context).of("pls_enter_email"),
                style: TextStyles(context).getDescriptionStyle(),
              ),
              Text(
                AppLocalizations(context).of("ex_email"),
                style: const TextStyle(
                    color: Color.fromARGB(255, 112, 79, 56),
                    fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: labelAndTextField(
                    context: context,
                    label: "email",
                    hintText: 'example@gmail.com',
                    controller: emailController,
                    errorText: error),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              CommonButton(
                onTap: sendPassResetEmail,
                buttonText: "send_verification_code",
                radius: 35,
                width: MediaQuery.of(context).size.width - 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkEmailSent(String mail) async {
    bool res = true;
    await AuthService().sendPassResetLink(mail).then((value) {
      if (value.toString() == '[firebase_auth/missing-email] Error') {
        setState(() {
          error = AppLocalizations(context).of("login_e1");
        });
        res = false;
      } else if (value.toString() ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        setState(() {
          error = AppLocalizations(context).of("login_e3");
        });
        res = false;
      }
    });
    return res;
  }

  Future sendPassResetEmail() async {
    loading(context);
    bool sendMailStatus = await checkEmailSent(emailController.text.trim());
    Navigator.pop(context);
    if (sendMailStatus == true) {
      setState(() {
        error = AppLocalizations(context).of("email_sent") +
            emailController.text.trim();
      });
    }
  }
}
