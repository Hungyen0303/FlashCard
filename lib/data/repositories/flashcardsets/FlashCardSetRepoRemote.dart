import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';

import '../../services/api/Api1.dart';

class FlashCardSetRepoRemote extends FlashCardSetRepo {
  FlashCardSetRepoRemote(this.api);
  List<FlashCardSet> cachedlocalListFlashCardSet = [];

  List<FlashCardSet> cachedlocalListFlashCardSetPublic = [];

  final Api api;

  @override
  Future<bool> addNewSetToPublic(FlashCardSet newSet) async {
    cachedlocalListFlashCardSetPublic.add(newSet);
    await api.publicSet(newSet.name);
    return true;
  }

  @override
  Future<List<FlashCardSet>> getAllSetPublic() async {
    try {
      if (cachedlocalListFlashCardSetPublic.isEmpty) {
        cachedlocalListFlashCardSetPublic =
            await api.getAllFlashcardSetPublic();
      }
      return cachedlocalListFlashCardSetPublic;
    } catch (e) {
      rethrow;
    }
    return [];
  }

  @override
  Future<List<FlashCardSet>> getAll() async {
    try {
      if (cachedlocalListFlashCardSet.isEmpty) {
        cachedlocalListFlashCardSet = await api.getAllFlashcardSet();
      }
      return cachedlocalListFlashCardSet;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addNewSet(FlashCardSet newSet) async {
    try {
      bool success = await api.addNewSet(newSet);
      if (success) {
        cachedlocalListFlashCardSet.add(newSet);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editASet(String nameOfSet, FlashCardSet newSet) async {
    try {
      bool success = await api.updateSet(nameOfSet, newSet);
      if (success) {
        final index = cachedlocalListFlashCardSet
            .indexWhere((old) => old.name == nameOfSet);
        if (index != -1) {
          cachedlocalListFlashCardSet[index] = newSet;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteASet(String name) async {
    try {
      bool success = await api.deleteSet(name);
      if (success) {
        cachedlocalListFlashCardSet
            .removeWhere((element) => element.name == name);
      }
      return true;
    } catch (e) {
      return false;
    }
    return true;
  }
}
