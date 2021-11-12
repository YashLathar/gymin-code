import 'dart:convert';

import 'package:flutter/foundation.dart';

class Gym {
  final bool gymopen;
  final bool traineravailable;
  final List gymphotos;
  final String gymId;
  final String gymName;
  final String gymPhoto;
  final String gymratings;
  final String trainername;
  final String gymaddress;

  final String trainerphoto;
  final String trainerrating;
  Gym({
    required this.gymopen,
    required this.traineravailable,
    required this.gymphotos,
    required this.gymId,
    required this.gymName,
    required this.gymPhoto,
    required this.gymratings,
    required this.trainername,
    required this.gymaddress,
    required this.trainerphoto,
    required this.trainerrating,
  });

  Gym copyWith({
    bool? gymopen,
    bool? traineravailable,
    List? gymphotos,
    String? gymId,
    String? gymName,
    String? gymPhoto,
    String? gymratings,
    String? trainername,
    String? gymaddress,
    String? trainerphoto,
    String? trainerrating,
  }) {
    return Gym(
      gymopen: gymopen ?? this.gymopen,
      traineravailable: traineravailable ?? this.traineravailable,
      gymphotos: gymphotos ?? this.gymphotos,
      gymId: gymId ?? this.gymId,
      gymName: gymName ?? this.gymName,
      gymPhoto: gymPhoto ?? this.gymPhoto,
      gymratings: gymratings ?? this.gymratings,
      trainername: trainername ?? this.trainername,
      gymaddress: gymaddress ?? this.gymaddress,
      trainerphoto: trainerphoto ?? this.trainerphoto,
      trainerrating: trainerrating ?? this.trainerrating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gymopen': gymopen,
      'traineravailable': traineravailable,
      'gymphotos': gymphotos,
      'gymId': gymId,
      'gymName': gymName,
      'gymPhoto': gymPhoto,
      'gymratings': gymratings,
      'trainername': trainername,
      'gymaddress': gymaddress,
      'trainerphoto': trainerphoto,
      'trainerrating': trainerrating,
    };
  }

  factory Gym.fromMap(Map<String, dynamic> map) {
    return Gym(
      gymopen: map['gymopen'],
      traineravailable: map['traineravailable'],
      gymphotos: List.from(map['gymphotos']),
      gymId: map['gymId'],
      gymName: map['gymName'],
      gymPhoto: map['gymPhoto'],
      gymratings: map['gymratings'],
      trainername: map['trainername'],
      gymaddress: map['gymaddress'],
      trainerphoto: map['trainerphoto'],
      trainerrating: map['trainerrating'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Gym.fromJson(String source) => Gym.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Gym(gymopen: $gymopen, traineravailable: $traineravailable, gymphotos: $gymphotos, gymId: $gymId, gymName: $gymName, gymPhoto: $gymPhoto, gymratings: $gymratings, trainername: $trainername, gymaddress: $gymaddress, trainerphoto: $trainerphoto, trainerrating: $trainerrating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Gym &&
        other.gymopen == gymopen &&
        other.traineravailable == traineravailable &&
        listEquals(other.gymphotos, gymphotos) &&
        other.gymId == gymId &&
        other.gymName == gymName &&
        other.gymPhoto == gymPhoto &&
        other.gymratings == gymratings &&
        other.trainername == trainername &&
        other.gymaddress == gymaddress &&
        other.trainerphoto == trainerphoto &&
        other.trainerrating == trainerrating;
  }

  @override
  int get hashCode {
    return gymopen.hashCode ^
        traineravailable.hashCode ^
        gymphotos.hashCode ^
        gymId.hashCode ^
        gymName.hashCode ^
        gymPhoto.hashCode ^
        gymratings.hashCode ^
        trainername.hashCode ^
        gymaddress.hashCode ^
        trainerphoto.hashCode ^
        trainerrating.hashCode;
  }
}
