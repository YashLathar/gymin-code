import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_in/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read),
);

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _read(authServiceProvider).userChanges.listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    await _read(authServiceProvider).signInWithEmail(email, password, context);
  }

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    await _read(authServiceProvider).signUpWithEmail(email, password, context);
  }

  Future<void> setUserName(String? newUsername) async {
    await _read(authServiceProvider).setDisplayName(newUsername);
  }

  Future<void> setProfilePhoto(String? photoUrl) async {
    await _read(authServiceProvider).setProfilePhoto(photoUrl);
  }

  // Future<void> setBio(String? newBio) async {
  //   await _read(authServiceProvider).setBio(newBio);
  // }

  void signOut() async {
    await _read(authServiceProvider).signOut();
  }
}
