import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/repositories/auth/AuthRepository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class AuthRepositoryRemote extends AuthRepository {
  final Dio dio = Dio();
  final Api1 _api1 = Api1Impl();

  User? cachedUser = null;

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
