import 'package:clothing_store_app/services/auth/auth_service.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/colors.dart';
import '../../widgets/common_button.dart';

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

  final TextStyle _style1 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.black
  );

  final TextStyle _style2 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: greyText
  );

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

    if (_nameController.text.isEmpty){
      setState(() {
        _nameError = 'Customer name is required';
      });
    }
    else{
      _isNameValid(_nameController.text.trim());
      setState(() {
        _nameError = 'Name should not contain special characters.';
      });
    }

    if (_emailController.text.isEmpty){
      setState(() {
        _emailError = 'Email account is required';
      });
    }

    if (_passwordController.text.isEmpty){
      setState(() {
        _passwordError = 'Password is required';
      });
    }

    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need to agree with our terms and conditions.')),
      );
      return;
    }

    try {
      String? userId = await AuthService().registerWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (userId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.brown,
            ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
        case 'weak-password':
          _passwordError = 'The password is too weak';
          break;
        case 'email-already-in-use':
          _emailError = 'An account already exists with that email';
          break;
        case 'invalid-email':
          _emailError = 'Email address is not valid';
          break;
        default:
          _emailError = _passwordError = 'An undefined error occurred.';
      }
      });
    }
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
                  'Create Account',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30.0,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Fill your information below or register with your social account.',
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: greyText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: _style1,),
                        const SizedBox(height: 5.0,),
                        CommonTextField(
                          textEditingController: _nameController,
                          contentPadding: const EdgeInsets.all(16.0),
                          hintTextStyle: _style2,
                          hintText: 'John Doe',
                          focusColor: Colors.brown,
                          textFieldPadding: const EdgeInsets.all(0.0),
                          errorText: _nameError,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: _style1,),
                        const SizedBox(height: 5.0,),
                        CommonTextField(
                          textEditingController: _emailController,
                          contentPadding: const EdgeInsets.all(16.0),
                          hintTextStyle: _style2,
                          hintText: 'example@gmail.com',
                          focusColor: Colors.brown,
                          textFieldPadding: const EdgeInsets.all(0.0),
                          errorText: _emailError,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password', style: _style1,),
                        const SizedBox(height: 5.0,),
                        Stack(
                          children: [
                            CommonTextField(
                              isObscureText: _showPassword,
                              textEditingController: _passwordController,
                              contentPadding: const EdgeInsets.all(16.0),
                              hintTextStyle: _style2,
                              hintText: '********',
                              focusColor: Colors.brown,
                              textFieldPadding: const EdgeInsets.all(0.0),
                              errorText: _passwordError,
                            ),
                            Positioned(
                              top: 6,
                              right: 10,
                              child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(_showPassword? Iconsax.eye_slash : Iconsax.eye, size: 20),
                            ),)
                          ],
                        ),
                      ],
                    ),
                  ),
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
                          TextSpan(text: 'Agree with ', style: _style1),
                          TextSpan(
                            text: 'Terms & Condition',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: lightBrown2,
                              decoration: TextDecoration.underline
                            ),
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
                  backgroundColor: darkBrown,
                  buttonText: 'Sign Up',
                  buttonTextWidget: Text(
                    "Sign Up",
                    style: GoogleFonts.inter(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
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
                    const Flexible(
                      child: Divider(
                        color: greyText,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                      )
                    ),
                    Text('Or sign up with', style: _style2,),
                    const Flexible(
                      child: Divider(
                        color: greyText,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      )
                    )
                  ],
                ),
              ),
              //Apple, Google, Facebook
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(border: Border.all(color: greyText), borderRadius: BorderRadius.circular(100)),
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: const Image(
                    //       width: 20,
                    //       height: 20,
                    //       image: AssetImage("assets/images/apple_logo.png")
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(width: 16.0,),
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: greyText), borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          width: 20,
                          height: 20,
                          image: AssetImage("assets/images/google_logo.png")
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0,),
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: greyText), borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          width: 20,
                          height: 20,
                          image: AssetImage("assets/images/facebook_logo.png")
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
                    "Already have an account?",
                    style: _style1,
                  ),
                  TextButton(
                      onPressed: () {
                        //Sign in
                      },
                      child: Text (
                        "Sign in",
                        style: GoogleFonts.inter(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: lightBrown2,
                          decoration: TextDecoration.underline
                        ),
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
}