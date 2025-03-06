import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepoLocal.dart';
import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flutter/cupertino.dart';

class SpecificFlashCardViewModel extends ChangeNotifier {
  final SpecificFlashCardRepo _repo = SpecificFlashCardRepoLocal();

  List<FlashCard> flashcardList = [];

  Future<bool> getAll(String nameOfSet) async {
    _repo.setNameOfSet(nameOfSet);
    flashcardList = await _repo.getAll();
    notifyListeners();
    return true;
  }

  Future<bool> addACard(FlashCard newCard) async {
    bool success = await _repo.addNewCard(newCard);
    flashcardList = await _repo.getAll();
    notifyListeners();
    return success;
  }

  Future<bool> editACard(FlashCard oldCard, FlashCard newCard) async {
    bool success = await _repo.editACard(oldCard, newCard);
    notifyListeners();
    return success;
  }

  Future<bool> deleteACard(FlashCard card) async {
    bool success = await _repo.deleteACard(card);
    notifyListeners();
    return success;
  }
}
