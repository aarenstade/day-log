import 'package:daylog/services/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthResponse {
  bool success;
  String message;
  AuthResponse({this.success, this.message});
}

class AuthFunctions {
  static final auth = FirebaseAuth.instance;

  static List<String> getUser() {
    var user = auth.currentUser;
    if (user != null) {
      return [user.uid, user.email];
    } else {
      return null;
    }
  }

  static Future<AuthResponse> login({String email, String pass}) async {
    try {
      final user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      print("signed in!");
      return AuthResponse(message: user.user.uid, success: true);
    } on PlatformException catch (e) {
      var err = e.toString();
      return handleFirebaseError(err);
    } on FirebaseAuthException catch (e) {
      var err = e.toString();
      return handleFirebaseError(err);
    } catch (e) {
      var err = e.toString();
      return handleFirebaseError(err);
    }
  }

  static Future<AuthResponse> createAccount({String email, String pass}) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return AuthResponse(message: user.user.uid, success: true);
    } on PlatformException catch (e) {
      var err = e.toString();
      return handleFirebaseError(err);
    } on FirebaseAuthException catch (e) {
      var err = e.toString();
      return handleFirebaseError(err);
    } catch (e) {
      var err = e.toString();
      return handleFirebaseError(err);
    }
  }

  static Future<void> sendPassResetLink(String email) async {
    try {
      print(email);
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error sending reset link");
    }
  }

  static Future<void> logout() async {
    await auth.signOut();
  }
}
