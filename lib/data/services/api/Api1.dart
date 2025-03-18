import 'package:flashcard_learning/domain/models/user.dart';

/// API1 using spring boot for backend

abstract class Api1 {
  Future<void> login((String, String) credentials);

  Future<void> signUp((String, String, String) credentials);

  Future<void> getUser();

  Future<void> updateUser(User newUser);
}
