import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/repositories/auth/AuthRepository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote(this.api);
  final Api api;

  User? cachedUser = null;

  @override
  Future<void> login(String username, String password) async {
    try {
      await api.login((username, password));
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"]);
    }
  }

  @override
  Future<User?> getUser(String username) async {
    if (cachedUser == null && username != cachedUser!.username) {
      api.getUser();
    }
    return cachedUser;
  }

  @override
  Future<void> signUp(String email, String username, String password) async {
    try {
      await api.signUp((email, username, password));
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"]);
    }
  }
}
