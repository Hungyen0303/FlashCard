import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';

import '../../../domain/models/user.dart';
import '../chatWithAI/ChatWithAIRepo.dart';
import '../flashcardsets/FlashCardSetRepo.dart';
import '../search_result/search_result_repository.dart';
import '../specific_flashcard/SpecificFlashCardRepo.dart';

class AccountRepositoryRemote extends AccountRepository {
  AccountRepositoryRemote();



  Map<String, dynamic> cachedData = {};

  int cachedNumOfCompleteFlashcardSet = -1;

  int cachedNumOfCompleteConversation = -1;

  Api1 api1 = Api1Impl();

  @override
  void setImage(String path) {
    // TODO: implement setImage
  }

  @override
  Future<void> logout() {
    AppManager.clearToken();
    clearCached();
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(User newUser) async {
    try {
      await api1.updateUser(newUser);
    } catch (e) {}
  }

  @override
  Future<User?> getUser() async {
    if (AppManager.getUser() != null)
      return AppManager.getUser();
    else
      return null;
  }

  @override
  void clearCached() {}

  @override
  Future<Map<String, int>> getTrackData() {
    return api1.getTrackData();
  }

  @override
  Future<void> postTrack() async {
    await api1.postTrack();
  }
}
