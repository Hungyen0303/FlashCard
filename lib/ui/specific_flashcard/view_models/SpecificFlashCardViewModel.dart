import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepoLocal.dart';
import 'package:flashcard_learning/domain/models/Flashcard.dart';

class SpecificFlashCardViewModel {
  SpecificFlashCardRepo repo = SpecificFlashCardRepoLocal();

  Future<List<FlashCard>> getAll() async {
    return await repo.getAll();
  }
}
