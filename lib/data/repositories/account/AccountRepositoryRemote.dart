import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/data/services/api/api.dart';

import '../../../AppManager.dart';
import '../../../domain/models/user.dart';

class AccountRepositoryRemote extends AccountRepository {
  AccountRepositoryRemote({required this.api});

  final Api api;

  @override
  void setImage(String path) {
    // TODO: implement setImage
  }

  @override
  Future<void> logout() async {
    await AppManager.logout();
    //await AppCachedData.clearCachedData();
  }

  @override
  Future<void> updateUser(User newUser) async {
    try {
      await api.updateUser(newUser);
    } catch (e) {
      // TODO hasError and showEror
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      return await api.getUser();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, int>> getTrackData() async {
    return await api.getTrackData();
  }

  @override
  Future<void> postTrack() async {
    await api.postTrack();
  }
}
