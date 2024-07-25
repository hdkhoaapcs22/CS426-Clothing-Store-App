import 'package:clothing_store_app/modules/verification_page.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool isShowingPass1 = false;
  bool isShowingPass2 = false;
  @override
  Widget build(BuildContext context) {
    TextStyles textStyle = TextStyles(context);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
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
                          left: 21,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: IgnorePointer(
                              child: Image.asset(
                                'assets/images/left_arrow.png',
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
              const Text(
                'New Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              Text(
                'Your new password must be different',
                style: textStyle.getDescriptionStyle(),
              ),
              Text(
                'from previously used passwords.',
                style: textStyle.getDescriptionStyle(),
              ),
              const Padding(padding: EdgeInsets.all(24)),
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
                      onSubmitted: hihi,
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
                        isShowingPass1 = !isShowingPass1;
                      });
                    },
                    child: Image.asset(
                      isShowingPass1 == false
                          ? 'assets/images/hide_pass_icon.png'
                          : 'assets/images/show_pass_icon.png',
                      width: 40,
                      height: 30,
                    ),
                  ),
                ),
              ]),
              const Padding(padding: EdgeInsets.all(12)),
              SizedBox(
                width: 380,
                child: Row(
                  children: [
                    Text(
                      'Confirm Password',
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
                      onSubmitted: hihi,
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
                        isShowingPass2 = !isShowingPass2;
                      });
                    },
                    child: Image.asset(
                      isShowingPass2 == false
                          ? 'assets/images/hide_pass_icon.png'
                          : 'assets/images/show_pass_icon.png',
                      width: 40,
                      height: 30,
                    ),
                  ),
                ),
              ]),
              const Padding(padding: EdgeInsets.all(18)),
              SizedBox(
                width: 380,
                child: CommonButton(
                  buttonTextWidget: const Text('Create New Password',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  radius: 35,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VerificationPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void hihi(String s) {
    print(s);
  }
}
