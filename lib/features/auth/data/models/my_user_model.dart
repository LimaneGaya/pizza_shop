import 'dart:convert';
import 'package:food_delivery/core/entities/my_user.dart';

class MyUserModel extends MyUser {
  MyUserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.hasActiveCart,
    required super.isAdmin,
  });
  factory MyUserModel.empty() {
    return MyUserModel(
        uid: '', email: '', name: '', hasActiveCart: false, isAdmin: false);
  }

  MyUserModel copyWith({
    String? uid,
    String? email,
    String? name,
    bool? hasActiveCart,
    bool? isAdmin,
  }) {
    return MyUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      hasActiveCart: hasActiveCart ?? this.hasActiveCart,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
      'isAdmin': isAdmin
    };
  }

  factory MyUserModel.fromMap(Map<String, dynamic> map) {
    if (map
        case {
          'uid': String uid,
          'email': String email,
          'name': String name,
          'hasActiveCart': bool hasActiveCart,
          'isAdmin': bool isAdmin
        }) {
      return MyUserModel(
        uid: uid,
        email: email,
        name: name,
        hasActiveCart: hasActiveCart,
        isAdmin: isAdmin,
      );
    } else {
      throw Exception('Unexpected data format');
    }
  }
  MyUserModel.fromUser(MyUser user)
      : this(
          uid: user.uid,
          email: user.email,
          name: user.name,
          hasActiveCart: user.hasActiveCart,
          isAdmin: user.isAdmin,
        );
  String toJson() => json.encode(toMap());

  factory MyUserModel.fromJson(String source) =>
      MyUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyUserModel(uid: $uid, email: $email, name: $name, hasActiveCart: $hasActiveCart, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyUserModel &&
        other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.hasActiveCart == hasActiveCart &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        hasActiveCart.hashCode ^
        isAdmin.hashCode;
  }
}
