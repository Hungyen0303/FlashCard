import 'package:flashcard_learning/data/repositories/auth/AuthRepository.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class Authrepositorylocal extends AuthRepository {
  final Map<String, String> fakeAccounts = {
    "user1@gmail.com": "password1",
    "user2@gmail.com": "password2",
    "user3@gmail.com": "password3",
    "user4@gmail.com": "password4",
    "user5@gmail.com": "password5",
  };

  @override
  Future<String> login(String username, String password) async {
    // Fake time for Calling API
    await Future.delayed(const Duration(seconds: 1));

    if (fakeAccounts.containsKey(username) &&
        fakeAccounts[username] == password) {
      return "token";
    }
    return " fail to login ";
  }

  @override
  Future<User> getUser(String username) async {
    await Future.delayed(const Duration(seconds: 1));
    return User.named(name: "John Wick ", avatarPath: "avatar", plan: "Basic");
  }
}
