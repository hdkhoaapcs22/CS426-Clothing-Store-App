import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:clothing_store_app/widgets/label_and_textfield.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
          child: Column(
            children: [
              Row(
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
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations(context).of("email"),
                style: TextStyles(context).getLargerHeaderStyle(false),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations(context).of("pls_enter_email"),
                style:
                    TextStyles(context).getInterDescriptionStyle(false, false),
                textAlign: TextAlign.center,
              ),
              Text(
                AppLocalizations(context).of("ex_email"),
                style: const TextStyle(
                    color: Color.fromARGB(255, 112, 79, 56),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              labelAndTextField(
                  context: context,
                  label: "email",
                  hintText: 'example@gmail.com',
                  controller: emailController,
                  errorText: error),
              const Padding(padding: EdgeInsets.all(4)),
              CommonButton(
                onTap: sendPassResetEmail,
                radius: 30.0,
                backgroundColor: AppTheme.brownButtonColor,
                buttonTextWidget: Text(
                  AppLocalizations(context).of("send_verification_code"),
                  style: TextStyles(context).getButtonTextStyle(),
                ),
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
      if (value.toString().contains('missing-email')) {
        setState(() {
          error = AppLocalizations(context).of("login_e1");
        });
        res = false;
      } else if (value.toString().contains('invalid-email')) {
        setState(() {
          error = AppLocalizations(context).of("login_e3");
        });
        res = false;
      }
    });
    return res;
  }

  Future sendPassResetEmail() async {
    Dialogs(context).showLoadingDialog();
    bool sendMailStatus = await checkEmailSent(emailController.text.trim());
    Navigator.pop(context);
    if (sendMailStatus == true) {
      Dialogs(context).showAnimatedDialog(
          title: AppLocalizations(context).of("success"),
          content: AppLocalizations(context).of("email_sent") +
              emailController.text.trim());
    }
  }
}
