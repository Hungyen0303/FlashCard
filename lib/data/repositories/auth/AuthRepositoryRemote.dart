import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/repositories/auth/AuthRepository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote({required Api1 api1}) : _api1 = api1;

  final Api1 _api1;

  User? cachedUser;

  @override
  Future<void> login(String username, String password) async {
    try {
      await _api1.login((username, password));
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"]);
    }
  }

  @override
  Future<User?> getUser(String username) async {
    if (cachedUser == null && username != cachedUser!.username) {
      _api1.getUser();
    }
    return cachedUser;
  }

  @override
  Future<void> signUp(String email, String username, String password) async {
    try {
      await _api1.signUp((email, username, password));
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"]);
    }
  }
}
