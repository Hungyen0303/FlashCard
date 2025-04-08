import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:hive/hive.dart';

import '../../../AppCachedData.dart';
import '../../../AppManager.dart';
import '../../../domain/models/user.dart';

class AccountRepositoryRemote extends AccountRepository {
  AccountRepositoryRemote({required this.api1});

  final Api1 api1;

  @override
  void setImage(String path) {
    // TODO: implement setImage
  }

  @override
  Future<void> logout() async {
    await AppManager.logout();
    await AppCachedData.clearCachedData();
  }

  @override
  Future<void> updateUser(User newUser) async {
    try {
      await api1.updateUser(newUser);
    } catch (e) {
      // TODO hasError and showEror
    }
  }

  @override
  Future<User?> getUser() async {
    if (AppManager.getUser() != null)
      return AppManager.getUser();
    else
      return null;
  }

  @override
  Future<Map<String, int>> getTrackData() async {
    await Hive.openBox(RepoName.account.name);
    var box = Hive.box(RepoName.account.name);
    final rawData = box.get(RepoName.account.name);
    Map<String, int> cachedData = {};
    if (rawData is Map) {
      cachedData = rawData.map(
        (key, value) => MapEntry(key.toString(), value as int),
      );
    }

    if (cachedData == null || cachedData.isEmpty) {
      cachedData = await api1.getTrackData();
      box.put(RepoName.account.name, cachedData);
    }
    return cachedData;
  }

  @override
  Future<void> postTrack() async {
    await api1.postTrack();
  }
}
