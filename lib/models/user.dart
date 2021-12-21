import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserInApp {
  final int height;
  final int weight;
  final int phoneNumber;
  final int age;
  final String userName;
  final String userPhoto;
  final String bio;
  final String about;
  final String address;
  UserInApp({
    required this.height,
    required this.weight,
    required this.phoneNumber,
    required this.age,
    required this.userName,
    required this.userPhoto,
    required this.bio,
    required this.about,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'weight': weight,
      'phoneNumber': phoneNumber,
      'age': age,
      'userName': userName,
      'userPhoto': userPhoto,
      'bio': bio,
      'about': about,
      'address': address,
    };
  }

  factory UserInApp.fromMap(Map<String, dynamic> map) {
    return UserInApp(
      height: map['height']?.toInt() ?? 0,
      weight: map['weight']?.toInt() ?? 0,
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      age: map['age']?.toInt() ?? 0,
      userName: map['userName'] ?? '',
      userPhoto: map['userPhoto'] ?? '',
      bio: map['bio'] ?? '',
      about: map['about'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInApp.fromJson(String source) =>
      UserInApp.fromMap(json.decode(source));

  factory UserInApp.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserInApp.fromMap(data);
  }

  @override
  String toString() {
    return 'UserInApp(height: $height, weight: $weight, phoneNumber: $phoneNumber, age: $age, userName: $userName, userPhoto: $userPhoto, bio: $bio, about: $about, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInApp &&
        other.height == height &&
        other.weight == weight &&
        other.phoneNumber == phoneNumber &&
        other.age == age &&
        other.userName == userName &&
        other.userPhoto == userPhoto &&
        other.bio == bio &&
        other.about == about &&
        other.address == address;
  }

  @override
  int get hashCode {
    return height.hashCode ^
        weight.hashCode ^
        phoneNumber.hashCode ^
        age.hashCode ^
        userName.hashCode ^
        userPhoto.hashCode ^
        bio.hashCode ^
        about.hashCode ^
        address.hashCode;
  }

  UserInApp copyWith({
    int? height,
    int? weight,
    int? phoneNumber,
    int? age,
    String? userName,
    String? userPhoto,
    String? bio,
    String? about,
    String? address,
  }) {
    return UserInApp(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      userName: userName ?? this.userName,
      userPhoto: userPhoto ?? this.userPhoto,
      bio: bio ?? this.bio,
      about: about ?? this.about,
      address: address ?? this.address,
    );
  }
}
