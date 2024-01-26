import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String profilePic;
  final String banner;
  final String uid;
  UserModel({
    required this.name,
    required this.profilePic,
    required this.banner,
    required this.uid,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? banner,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'banner': banner,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      banner: map['banner'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, banner: $banner, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.banner == banner &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    profilePic.hashCode ^
    banner.hashCode ^
    uid.hashCode;
  }
}