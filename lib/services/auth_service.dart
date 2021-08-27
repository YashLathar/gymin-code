import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  User? getCurrentUser();
  String? getCurrentUID();
  Future<void> signOut();
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

  //  //
  // class AuthService {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid,);
  //  // sign up with email and password
  // Future<String> createUserWithEmailAndPassword(
  //    String email, String password, String name) async {
  // final CurrentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,)

  //  // update the username
  // var userUpdateInfo = UserUpdateInfo();
  // userUpdateInfo.displayName = username;
  // await currentUser.updateProfile(userUpdateInfo);
  // await currentUser.reload();
  // return currentUser.uid;

  //  // sign in with email and password
  // Future<String> signInWithEmailAndPassword(
  //    String email, Strinng password) async {
  //   return (await _firebaseAuth.signInWithEmailAndPassword(
  //           email: email, password: password)).uid}

  //  // sign out
  // signOut() {
  // return _firebaseAuth.signOut();
  // }
  // }

}

// class AuthenticationService {
//   final FirebaseAuth _firebaseAuth;

//   AuthenticationService(this._firebaseAuth);

//   Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

//   Future<void> signIn(
//       String email, String password, BuildContext context) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       // throw e.message;
//       return ErrorHandler().errorDialog(context, e);
//     }
//   }

//   Future<void> signUp(
//       String email, String password, BuildContext context) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
// } on FirebaseAuthException catch (e) {
//   return ErrorHandler().errorDialog(context, e);
// }
//   }

//   Future<UserCredential> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser!.authentication;

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
// }
