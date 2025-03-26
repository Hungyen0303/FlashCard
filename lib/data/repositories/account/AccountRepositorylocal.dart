import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class AccountRepositoryLocal extends AccountRepository {
  // Local path
  String pathOfImage = "";
  String plan = "Basic";

  @override
  void setImage(String path) {
    pathOfImage = path;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> updateUser(User newUser) async {}

  @override
  Future<User?> getUser() async {}

  @override
  Future<Map<String, int>> getTrackData() async {
    return {};
  }

  @override
  Future<void> updateTrackData(
      int numOfCompleteFlashcard, int numOfCompleteConversation) async {
//
  }

  @override
  Future<void> postTrack() async {

  }
}
