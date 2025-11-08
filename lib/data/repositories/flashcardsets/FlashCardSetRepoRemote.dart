import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';

import '../../services/api/api.dart';

class FlashCardSetRepoRemote extends FlashCardSetRepo {
  FlashCardSetRepoRemote({required this.api});

  final Api api;

  @override
  Future<bool> addNewSetToPublic(FlashCardSet newSet) async {
    await api.publicSet(newSet.name);
    return true;
  }

  @override
  Future<List<FlashCardSet>> getAllSetPublic() async {
    try {
      return await api.getAllFlashcardSetPublic();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FlashCardSet>> getAll() async {
    try {
      return await api.getAllFlashcardSet();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addNewSet(FlashCardSet newSet) async {
    try {
      await api.addNewSet(newSet);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editASet(String nameOfSet, FlashCardSet newSet) async {
    try {
      await api.updateSet(nameOfSet, newSet);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteASet(String name) async {
    try {
      return await api.deleteSet(name);
    } catch (e) {
      return false;
    }
  }
}
