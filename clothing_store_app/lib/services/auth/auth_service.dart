// import 'package:booking_new_hotel/modules/profile/user.dart';
import 'dart:async';
import 'dart:developer';

import 'package:clothing_store_app/routes/routes_name.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../languages/appLocalizations.dart';
import '../../routes/navigation_services.dart';
import '../../widgets/common_dialogs.dart';

class AuthService {
  // firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // register with email and password
  Future<String?> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user != null ? user.uid : null;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  FirebaseAuth getAuthInstance() {
    return _auth;
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user != null ? user.uid : null;
    } catch (e) {
      return e;
    }
  }

  //sign in with google
  Future<String?> signInWithGoogle(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("Google sign-in was canceled.");
        return null;
      }

      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null && googleAuth.accessToken == null) {
        print("Failed to get ID token or access token from Google.");
        return null;
      }

      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        if (result.additionalUserInfo!.isNewUser) {
          await Dialogs(context).showAnimatedDialog(
              title: AppLocalizations(context).of("sign_up_with_google"),
              content: AppLocalizations(context)
                  .of("sign_up_with_google_successfully"));
          NavigationServices(context).pushCompleteProfileScreen();
        } else {
          NavigationServices(context).gotoBottomTapScreen();
        }
      }
      return user?.uid;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future updateUserPassword({required String newPassword}) async {
    try {
      return await FirebaseAuth.instance.currentUser!
          .updatePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }

  // sign out
  Future signOutAccount() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  // get email
  Future getEmail() async {
    try {
      return _auth.currentUser!.email;
    } catch (e) {
      return null;
    }
  }

  //forget pass
  Future sendPassResetLink(String mail) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
    } catch (e) {
      return e;
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await UserInformationService().deleteUser();
      await _auth.currentUser!.delete();
      if (_auth.currentUser == null) {
        await Dialogs(context).showAnimatedDialog(
            title: AppLocalizations(context).of("delete_account"),
            content:
                AppLocalizations(context).of("delete_account_successfully"));
        Navigator.popUntil(
          context,
          ModalRoute.withName(RoutesName.splashScreen),
        );
        NavigationServices(context).pushSignUpScreen();
      } else {
        throw Exception("Account deletion failed.");
      }
    } on FirebaseAuthException catch (e) {
      await Dialogs(context).showErrorDialog(message: e.toString());
    }
  }

  Future<String?> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        UserCredential result =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = result.user;

        if (user != null) {
          if (result.additionalUserInfo!.isNewUser) {
            print("SIGN UP FACEBOOK SUCCESSFULLY!");
            await Dialogs(context).showAnimatedDialog(
                title: AppLocalizations(context).of("sign_up_with_facebook"),
                content: AppLocalizations(context)
                    .of("sign_up_with_facebook_successfully"));
            NavigationServices(context).pushCompleteProfileScreen();
          } else {
            NavigationServices(context).gotoBottomTapScreen();
          }
        }
        return user?.uid;
      } else {
        print('Facebook login failed with status: ${loginResult.status}');
        Navigator.pop(context);
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
      rethrow;
    } catch (e) {
      print('Other Exception: $e');
      rethrow;
    }
  }

}
