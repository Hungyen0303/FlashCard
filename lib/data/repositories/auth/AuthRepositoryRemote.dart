import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/repositories/auth/AuthRepository.dart';
import 'package:flashcard_learning/data/services/api/api.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote({required Api api}) : _api = api;

  final Api _api;

  User? cachedUser;

  @override
  Future<void> login(String username, String password) async {
    try {
      await _api.login((username, password));
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"]);
    }
  }

  @override
  Future<User?> getUser(String username) async {
    if (cachedUser == null && username != cachedUser!.username) {
      _api.getUser();
    }
    return cachedUser;
  }

  @override
  Future<void> signUp(String email, String username, String password) async {
    try {
      await _api.signUp((email, username, password));
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"]);
    }
  }
}
