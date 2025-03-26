import 'dart:core';
import 'dart:io';

class User {
  String username = '';

  String name = '';
  String plan = '';
  String avatar = '';

  User();

  User.named(
      {required this.username,
      required this.name,
      required this.plan,
      required this.avatar});

  User.fromJson(Map<String, dynamic> user) {
    name = user["name"] ?? "";
    plan = user["plan"] ?? "";
    avatar = user["avatarPath"] ??"" ;
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'plan': plan, 'avatar': avatar};
  }
}
