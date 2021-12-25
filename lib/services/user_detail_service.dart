import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseUserDetailService {
  Future<void> addUserInfo(
    int height,
    int age,
    int phoneNumber,
    int weight,
    String? userName,
    String? userPhoto,
    String bio,
    String about,
    String address,
    bool isTrainer,
    bool authorization,
  );
  Future<void> updateUserName(String newUserName);
  Future<void> updateUserPhoto(String newUserPhoto);
  Future<void> updateUserHeight(int updatedHeight);
  Future<void> updateUserAge(int updatedAge);
  Future<void> updateUserPhoneNumber(int updatedPhoneNumber);
  Future<void> updateUserWeight(int updatedWeight);
  Future<void> updateUserBio(String updatedBio);
  Future<void> updateUserAbout(String updatedAbout);
  Future<void> updateUserAddress(String updateAddress);
  Future<void> deleteUserInfo();
  Future<UserInApp> getYourInfo(String userUID);
}

final userDetailServiceProvider = Provider<UserDetailService>((ref) {
  final user = ref.read(authControllerProvider);
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
      String? userName,
      String? userPhoto,
      String bio,
      String about,
      String address,
      bool isTrainer,
      bool authorization) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .set({
        "phoneNumber": phoneNumber,
        "age": age,
        "height": height,
        "weight": weight,
        "userName": userName,
        "userPhoto": userPhoto,
        "bio": bio,
        "about": about,
        "address": address,
        "isTrainer": false,
        "authorization": false,
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
          userName: "not specified",
          userPhoto: "not given",
          bio: "not given",
          address: "not given",
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

  @override
  Future<void> updateUserAddress(String updateAddress) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "address": updateAddress,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserName(String newUserName) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "userName": newUserName,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserPhoto(String? newUserPhoto) async {
    try {
      await _read(firestoreProvider)
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        "userPhoto": newUserPhoto ?? "",
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
