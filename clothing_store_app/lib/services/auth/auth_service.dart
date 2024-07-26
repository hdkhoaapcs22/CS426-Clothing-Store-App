// import 'package:booking_new_hotel/modules/profile/user.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    }  on FirebaseAuthException catch (e) {
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
  Future<String?> signInWithGoogle() async {
    try{
      await GoogleSignIn().signOut();
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      return user != null ? user.uid : null;
    } catch (e){
      throw e;
    }
  }

  Future updateUserPassword({required String newPassword}) async {
    try {
      return await FirebaseAuth.instance.currentUser!
          .updatePassword(newPassword);
    } catch (e) {
      return e;
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
}
