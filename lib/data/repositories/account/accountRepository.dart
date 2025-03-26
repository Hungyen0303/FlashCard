import '../../../domain/models/user.dart';

abstract class AccountRepository {
  void setImage(String path);

  Future<void> logout();

  Future<void> updateUser(User newUser);

  Future<User?> getUser();


  Future<Map<String, int>> getTrackData();


}
