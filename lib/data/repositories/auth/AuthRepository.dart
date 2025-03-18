import '../../../domain/models/user.dart';

abstract class AuthRepository {
  Future<void> login(String username, String password);

  Future<void> signUp(String username, String password, String retypePassword);

  Future<void> getUser(String username);
}
