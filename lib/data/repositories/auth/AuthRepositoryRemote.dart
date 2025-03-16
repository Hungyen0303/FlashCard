import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/repositories/auth/AuthRepository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class AuthRepositoryRemote extends AuthRepository {
  final Dio dio = Dio();
  final Api1 _api1 = Api1Impl();

  @override
  Future<String> login(String username, String password) async {
    try {
      return await _api1.login((username, password));
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"]);
    }
  }

  @override
  Future<User> getUser(String username) async {
    await Future.delayed(const Duration(seconds: 1));
    return User.named(name: "John Wick ", avatarPath: "avatar", plan: "Basic");
  }
}
