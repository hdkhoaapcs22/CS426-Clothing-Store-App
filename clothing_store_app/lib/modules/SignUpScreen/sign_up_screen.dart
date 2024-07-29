import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/localfiles.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_dialogs.dart';
import '../../widgets/text_field_with_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _showPassword = false;
  bool _isAgreed = false;
  String _nameError = '';
  String _emailError = '';
  String _passwordError = '';

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  AppLocalizations(context).of("createAccount"),
                  style: TextStyles(context).getLargerHeaderStyle(false),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  AppLocalizations(context).of("createAccountDescript"),
                  style: TextStyles(context).getInterDescriptionStyle(false, false),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  TextFieldWithHeader(
                    controller: _nameController, 
                    errorMessage: _nameError, 
                    header: AppLocalizations(context).of("name"), 
                    hintText: AppLocalizations(context).of("John Doe"),
                    isPassword: false,),
                  TextFieldWithHeader(
                    controller: _emailController, 
                    errorMessage: _emailError, 
                    header: AppLocalizations(context).of("email"), 
                    hintText: AppLocalizations(context).of("example@gmail.com"),
                    isPassword: false,),
                  TextFieldWithHeader(
                    controller: _passwordController, 
                    errorMessage: _passwordError, 
                    header: AppLocalizations(context).of("password"), 
                    hintText: "********",
                    isPassword: true,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _isAgreed, 
                        onChanged: (value){
                          setState(() {
                            _isAgreed = value ?? false;
                          });
                        },
                      )
                    ),
                    const SizedBox(width: 10.0,),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: AppLocalizations(context).of("agree_with"), style: TextStyles(context).getInterDescriptionStyle(false, false)),
                          TextSpan(
                            text: AppLocalizations(context).of("terms_and_condition"),
                            style: TextStyles(context).getInterDescriptionStyle(true, true)
                          ),
                        ]
                      )
                    )
                ],),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CommonButton(
                  onTap: () async {
                    _registerAccount();
                  },
                  radius: 30.0,
                  backgroundColor: AppTheme.brownButtonColor,
                  buttonTextWidget: Text(
                    AppLocalizations(context).of("signUp"),
                    style: TextStyles(context).getButtonTextStyle(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0,),
              //Divider
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
                      )
                    ),
                    Text(AppLocalizations(context).of("orSignUpWith"), style: TextStyles(context).getInterDescriptionStyle(false, false),),
                    Flexible(
                      child: Divider(
                        color: AppTheme.secondaryTextColor,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      )
                    )
                  ],
                ),
              ),
              //Google, Facebook
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: AppTheme.secondaryTextColor), borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          width: 20,
                          height: 20,
                          image: AssetImage(Localfiles.googleLogo)
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0,),
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: AppTheme.secondaryTextColor), borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          width: 20,
                          height: 20,
                          image: AssetImage(Localfiles.facebookLogo)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations(context).of("alreadyHaveAccount"),
                    style: TextStyles(context).getInterDescriptionStyle(false, false),
                  ),
                  TextButton(
                      onPressed: () {
                        //Sign in
                      },
                      child: Text (
                        AppLocalizations(context).of("signIn"),
                        style: TextStyles(context).getInterDescriptionStyle(true, true),
                      )
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isNameValid(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegExp.hasMatch(name);
  }

  Future<void> _registerAccount() async {
    setState(() {
      _nameError = '';
      _emailError = '';
      _passwordError = '';
    });

    bool isValid = true;

    if (_nameController.text.isEmpty){
      setState(() {
         _nameError = AppLocalizations(context).of("name_is_required");
         isValid = false;
      });
    }
    else{
      if(!_isNameValid(_nameController.text.trim())){
        setState(() {
          _nameError = AppLocalizations(context).of("name_contains_characters");
          isValid = false;
        });
      }
    }

    if (_emailController.text.isEmpty){
      setState(() {
        _emailError = AppLocalizations(context).of("email_is_required");
        isValid = false;
      });
    }

    if (_passwordController.text.isEmpty){
      setState(() {
        _passwordError = AppLocalizations(context).of("password_is_required");
        isValid = false;
      });
    }

    if (isValid && !_isAgreed) {
      //Dialogs(context).showAlertDialog(content: 'You need to agree with our terms and conditions.');
      await Dialogs(context).showAnimatedDialog(title: 'Sign Up', content: 'You need to agree with our terms and conditions.');
      return;    
    }

    try {
      String? userId = await AuthService().registerWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (userId != null) {
        //await Dialogs(context).showAlertDialog(content: 'Registration successful!');
        await Dialogs(context).showAnimatedDialog(title: AppLocalizations(context).of("signUp"), content: AppLocalizations(context).of("register_successfully"));
        NavigationServices(context).pushCompleteProfileScreen();
      }
         
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
        case 'weak-password':
          _passwordError = AppLocalizations(context).of("weak_password");
          break;
        case 'email-already-in-use':
          _emailError = AppLocalizations(context).of("email_already_in_use");
          break;
        case 'invalid-email':
          _emailError = AppLocalizations(context).of("invalid_email");
          break;
        default:
          _emailError = _passwordError = AppLocalizations(context).of("undefined_error");
      }
      });
    }
  }
}