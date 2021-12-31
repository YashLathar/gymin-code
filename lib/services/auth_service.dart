import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/services/error_Handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseAuthenticationService {
  Stream<User?> get userChanges;
  Future<void> signInWithEmail(
      String email, String password, BuildContext context);
  Future<void> signUpWithEmail(
      String email, String password, BuildContext context);
  Future<void> setDisplayName(String newUsername);
  Future<void> setProfilePhoto(String photoUrl);
  Future<void> signInWithGoogle(BuildContext context);
  User? getCurrentUser();
  String? getCurrentUID();
  Future<void> signOut();
  Future<void> verifyUserEmail(
    String email,
    ActionCodeSettings actionCodeSettings,
  );
}

final authServiceProvider =
    Provider<AuthenticatioSevice>((ref) => AuthenticatioSevice(ref.read));

class AuthenticatioSevice implements BaseAuthenticationService {
  final Reader _read;

  const AuthenticatioSevice(this._read);

  @override
  Stream<User?> get userChanges => _read(firebaseAuthProvider).userChanges();

  // login with email and password
  @override
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      await _read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      context.read(loadingStateProvider).state = false;
      return ErrorHandler.errorDialog(context, e);
    }
  }

  @override
  Future<void> signUpWithEmail(
      String email, String password, BuildContext context) async {
    try {
      await _read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      context.read(loadingStateProvider).state = false;
      return ErrorHandler.errorDialog(context, e);
    }
  }

  @override
  User? getCurrentUser() {
    return _read(firebaseAuthProvider).currentUser;
  }

  @override
  Future<void> signOut() async {
    await _read(firebaseAuthProvider).signOut();
    GoogleSignIn().disconnect();
  }

  @override
  String? getCurrentUID() {
    return _read(firebaseAuthProvider).currentUser!.uid;
  }

  @override
  Future<void> setDisplayName(String? newUsername) async {
    await _read(firebaseAuthProvider)
        .currentUser!
        .updateDisplayName(newUsername);
  }

  @override
  Future<void> setProfilePhoto(String? photoUrl) async {
    await _read(firebaseAuthProvider).currentUser!.updatePhotoURL(photoUrl);
  }

  @override
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler.errorDialog(context, e);
    }
  }

  @override
  Future<void> verifyUserEmail(
    String email,
    ActionCodeSettings actionCodeSettings,
  ) async {
    try {
      await _read(firebaseAuthProvider).sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodeSettings);
    } on FirebaseAuthException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
