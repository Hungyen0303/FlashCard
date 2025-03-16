import 'package:flashcard_learning/domain/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/repositories/auth/AuthRepository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  void saveToken(String token, String refreshToken) {}

  bool _hasError = false;
  String _errorMessage = "";

  bool get hasError => _hasError;

  String get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    try {
      await _authRepository.login(username, password);
      saveToken("", "");
    } on Exception catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll("Exception:", "");
      notifyListeners();
    }
  }

  Future<User> getUser(String username) async {
    return await _authRepository.getUser(username);
  }
}
