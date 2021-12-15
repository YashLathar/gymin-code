import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/models/user.dart';
import 'package:gym_in/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseUserDetailService {
  Future<void> addUserInfo(
    int height,
    int age,
    int phoneNumber,
    int weight,
    String bio,
    String about,
  );
  Future<void> updateUserHeight(int updatedHeight);
  Future<void> updateUserAge(int updatedAge);
  Future<void> updateUserPhoneNumber(int updatedPhoneNumber);
  Future<void> updateUserWeight(int updatedWeight);
  Future<void> updateUserBio(String updatedBio);
  Future<void> updateUserAbout(String updatedAbout);
  Future<void> deleteUserInfo();
  Future<UserInApp> getYourInfo(String userUID);
}

final userDetailServiceProvider = Provider<UserDetailService>((ref) {
  final user = ref.read(authServiceProvider).getCurrentUser();
  return UserDetailService(ref.read, user);
});

class UserDetailService implements BaseUserDetailService {
  final Reader _read;
  final User? currentUser;

  UserDetailService(this._read, this.currentUser);

  @override
  Future<void> addUserInfo(
    int height,
    int age,
    int phoneNumber,
    int weight,
    String bio,
    String about,
  ) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .set({
        "phoneNumber": phoneNumber,
        "age": age,
        "height": height,
        "weight": weight,
        "bio": bio,
        "about": about,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<UserInApp> getYourInfo(String userUID) async {
    try {
      final doc =
          await _read(firestoreProvider).collection("users").doc(userUID).get();

      if (doc.exists) {
        final userInApp = UserInApp.fromDocument(doc);

        return userInApp;
      } else {
        return UserInApp(
          age: 0,
          about: "not given",
          phoneNumber: 0,
          height: 0,
          weight: 0,
          bio: "not given",
        );
      }
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> deleteUserInfo() async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserAbout(String updatedAbout) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "about": updatedAbout,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserAge(int updatedAge) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "age": updatedAge,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserBio(String updatedBio) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "bio": updatedBio,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserHeight(int updatedHeight) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "height": updatedHeight,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserPhoneNumber(int updatedPhoneNumber) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "phoneNumber": updatedPhoneNumber,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserWeight(int updatedWeight) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "weight": updatedWeight,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
