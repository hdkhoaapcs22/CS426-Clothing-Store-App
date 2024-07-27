// import 'package:booking_new_hotel/modules/profile/user.dart';
import 'dart:async';

import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    } catch (e) {
      return null;
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
}
