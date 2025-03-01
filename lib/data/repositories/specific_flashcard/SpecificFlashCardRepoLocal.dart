import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';

import '../../../domain/models/Flashcard.dart';

class SpecificFlashCardRepoLocal extends SpecificFlashCardRepo {
  @override
  Future<List<FlashCard>> getAll() async {
    await Future.delayed(Duration(seconds: 2));

    return [
      FlashCard("vietnamese", "tiếng việt ", "example"),
      FlashCard("english", "tiếng anh", "example"),
      FlashCard("thailand", "tiếng thái", "example"),
    ];
  }
}
