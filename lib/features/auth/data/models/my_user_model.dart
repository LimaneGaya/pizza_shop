import 'dart:convert';

import 'package:food_delivery/core/entities/my_user.dart';

class MyUserModel extends MyUser {
  MyUserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.hasActiveCart,
  });
  factory MyUserModel.empty() {
    return MyUserModel(uid: '', email: '', name: '', hasActiveCart: false);
  }

  MyUserModel copyWith({
    String? uid,
    String? email,
    String? name,
    bool? hasActiveCart,
  }) {
    return MyUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      hasActiveCart: hasActiveCart ?? this.hasActiveCart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
    };
  }

  factory MyUserModel.fromMap(Map<String, dynamic> map) {
    if (map
        case {
          'uid': String uid,
          'email': String email,
          'name': String name,
          'hasActiveCart': bool hasActiveCart,
        }) {
      return MyUserModel(
        uid: uid,
        email: email,
        name: name,
        hasActiveCart: hasActiveCart,
      );
    } else {
      throw Exception('Unexpected data format');
    }
  }

  String toJson() => json.encode(toMap());

  factory MyUserModel.fromJson(String source) =>
      MyUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyUserModel(uid: $uid, email: $email, name: $name, hasActiveCart: $hasActiveCart)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyUserModel &&
        other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.hasActiveCart == hasActiveCart;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        hasActiveCart.hashCode;
  }
}
