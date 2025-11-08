import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';

import '../../services/api/Api1.dart';

class FlashCardSetRepoRemote extends FlashCardSetRepo {
  FlashCardSetRepoRemote({required this.api1});

  final Api1 api1;

  @override
  Future<bool> addNewSetToPublic(FlashCardSet newSet) async {
    await api1.publicSet(newSet.name);
    return true;
  }

  @override
  Future<List<FlashCardSet>> getAllSetPublic() async {
    try {
      return await api1.getAllFlashcardSetPublic();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FlashCardSet>> getAll() async {
    try {
      return await api1.getAllFlashcardSet();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addNewSet(FlashCardSet newSet) async {
    try {
      await api1.addNewSet(newSet);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editASet(String nameOfSet, FlashCardSet newSet) async {
    try {
      await api1.updateSet(nameOfSet, newSet);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteASet(String name) async {
    try {
      return await api1.deleteSet(name);
    } catch (e) {
      return false;
    }
  }
}
