import 'package:flashcard_learning/domain/models/Flashcard.dart';

abstract class SpecificFlashCardRepo {
  void setNameOfSet(String newName);

  Future<List<FlashCard>> getAll(String nameOfSet);

  Future<bool> addNewCard(FlashCard flashcard);

  Future<bool> editACard(FlashCard oldCard, FlashCard newCard);

  Future<bool> deleteACard(FlashCard card);

  Future<bool> markDone(int index);
}
