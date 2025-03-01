import 'package:flashcard_learning/domain/models/user.dart';

import '../../../../data/repositories/auth/AuthRepository.dart';

class LoginViewModel {
  const LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<bool> login(String username, String password) async {
    return await _authRepository.login(username, password) == "token";

  }

  Future<User> getUser(String username) async {
    return await _authRepository.getUser(username);
  }


}
