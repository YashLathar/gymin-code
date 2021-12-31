import 'package:firebase_auth/firebase_auth.dart';
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
    String userUID,
  );
  Future<void> updateUserName(String newUserName, String userUID);
  Future<void> updateUserPhoto(String newUserPhoto, String userUID);
  Future<void> updateUserHeight(int updatedHeight, String userUID);
  Future<void> updateUserAge(int updatedAge, String userUID);
  Future<void> updateUserPhoneNumber(int updatedPhoneNumber, String userUID);
  Future<void> updateUserWeight(int updatedWeight, String userUID);
  Future<void> updateUserBio(String updatedBio, String userUID);
  Future<void> updateUserAbout(String updatedAbout, String userUID);
  Future<void> updateUserAddress(String updateAddress, String userUID);
  Future<void> deleteUserInfo(String userUID);
  Future<UserInApp> getYourInfo(String userUID);
}

final userDetailServiceProvider = Provider<UserDetailService>((ref) {
  return UserDetailService(ref.read);
});

class UserDetailService implements BaseUserDetailService {
  final Reader _read;

  UserDetailService(this._read);

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
      bool authorization,
      String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).set({
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
        final emptyUser = UserInApp(
          age: 0,
          about: "Not given",
          phoneNumber: 0,
          height: 0,
          weight: 0,
          userName: "Not specified",
          userPhoto: "Not given",
          bio: "Not given",
          address: "Not given",
        );

        await _read(firestoreProvider).collection("users").doc(userUID).set({
          "phoneNumber": emptyUser.phoneNumber,
          "age": emptyUser.age,
          "height": emptyUser.height,
          "weight": emptyUser.weight,
          "userName": emptyUser.userName,
          "userPhoto": emptyUser.userPhoto,
          "bio": emptyUser.bio,
          "about": emptyUser.about,
          "address": emptyUser.address,
          "isTrainer": false,
          "authorization": false,
        });
        return emptyUser;
      }
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> deleteUserInfo(String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).delete();
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserAbout(String updatedAbout, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "about": updatedAbout,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserAge(int updatedAge, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "age": updatedAge,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserBio(String updatedBio, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "bio": updatedBio,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserHeight(int updatedHeight, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "height": updatedHeight,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserPhoneNumber(
      int updatedPhoneNumber, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "phoneNumber": updatedPhoneNumber,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserWeight(int updatedWeight, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "weight": updatedWeight,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserAddress(String updateAddress, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "address": updateAddress,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserName(String newUserName, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "userName": newUserName,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> updateUserPhoto(String? newUserPhoto, String userUID) async {
    try {
      await _read(firestoreProvider).collection("users").doc(userUID).update({
        "userPhoto": newUserPhoto ?? "",
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
