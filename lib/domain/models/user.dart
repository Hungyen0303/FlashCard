import 'dart:core';

class User {
  String name = '';
  String plan = '';
  String avatarPath = '';

  User();

  User.named(
      {required this.name, required this.plan, required this.avatarPath});
}
