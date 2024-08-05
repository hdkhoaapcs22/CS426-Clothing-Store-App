import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/navigation_services.dart';
import '../services/auth/auth_service.dart';
import '../widgets/common_dialogs.dart';

class SignUpNotifier extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _isAgreed = false;
  String _emailError = '';
  String _passwordError = '';
  String _confirmPassError = '';

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPassController => _confirmPassController;
  bool get isAgreed => _isAgreed;
  String get emailError => _emailError;
  String get passwordError => _passwordError;
  String get confirmPassError => _confirmPassError;

  void setAgreeTermsAndCondition(bool value) {
    _isAgreed = value;
    notifyListeners();
  }

  void setEmailError(String error) {
    _emailError = error;
    notifyListeners();
  }

  void setPasswordError(String error) {
    _passwordError = error;
    notifyListeners();
  }

  void setConfirmPasswordError(String error) {
    _confirmPassError = error;
    notifyListeners();
  }

  bool isNameValid(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegExp.hasMatch(name);
  }

  bool validateFields(BuildContext context) {
    bool isValid = true;

    if (_emailController.text.trim().isEmpty) {
      setEmailError(AppLocalizations(context).of("email_is_required"));
      isValid = false;
    } else {
      setEmailError('');
    }

    if (_passwordController.text.isEmpty) {
      setPasswordError(AppLocalizations(context).of("password_is_required"));
      isValid = false;
    } else {
      setPasswordError('');
    }

    if (_confirmPassController.text.isEmpty) {
      setConfirmPasswordError(AppLocalizations(context).of("confirm_password_is_required"));
      isValid = false;
    } else if (_passwordController.text != _confirmPassController.text) {
      setConfirmPasswordError(AppLocalizations(context).of("confirm_pass_not_match"));
      isValid = false;
    } else {
      setConfirmPasswordError('');
    }
    return isValid;
  }

  Future<void> registerAccount(BuildContext context) async {
    if (validateFields(context)) {
      if (!isAgreed){
          Dialogs(context).showAnimatedDialog(
          title: AppLocalizations(context).of("signUp"),
          content: AppLocalizations(context).of("term_and_condition_error"));
          return;
      }
    }else{
      return;
    }

    try {
      Dialogs(context).showLoadingDialog();
      String? userId = await AuthService().registerWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      Navigator.of(context).pop();
      if (userId != null) {
        await Dialogs(context).showAnimatedDialog(
            title: AppLocalizations(context).of("signUp"),
            content: AppLocalizations(context).of("register_successfully"));
        NavigationServices(context).pushCompleteProfileScreen();
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      _handleFirebaseAuthError(e);
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        setPasswordError('The password is too weak.');
        break;
      case 'email-already-in-use':
        setEmailError('The account already exists for that email.');
        break;
      case 'invalid-email':
        setEmailError('The email address is not valid.');
        break;
      default:
        setEmailError('An undefined error occurred.');
        setPasswordError('An undefined error occurred.');
        break;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
