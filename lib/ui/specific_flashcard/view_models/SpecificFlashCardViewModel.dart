import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepoLocal.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepoRemote.dart';
import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flutter/cupertino.dart';

class SpecificFlashCardViewModel extends ChangeNotifier {
  final SpecificFlashCardRepo _repo = SpecificFlashCardRepoRemote();

  List<FlashCard> flashcardList = [];

  Future<void> loadData(String nameOfSet) async {
    await getAll(nameOfSet);
  }

  Future<bool> getAll(String nameOfSet) async {
    _repo.setNameOfSet(nameOfSet);
    flashcardList = await _repo.getAll(nameOfSet);
    notifyListeners();
    return true;
  }

  Future<bool> addACard(FlashCard newCard, String nameOfSet) async {
    try {
      bool success = await _repo.addNewCard(newCard);
      flashcardList = await _repo.getAll(nameOfSet);
      if (success) {
        loadData(nameOfSet);
        notifyListeners();
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editACard(
      FlashCard oldCard, FlashCard newCard, String name) async {
    try {
      bool success = await _repo.addNewCard(newCard);
      flashcardList = await _repo.getAll(name);
      if (success) {
        loadData(name);
        notifyListeners();
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteACard(FlashCard card, String name) async {
    try {
      bool success = await _repo.deleteACard(card);
      flashcardList = await _repo.getAll(name);
      if (success) {
        loadData(name);
        notifyListeners();
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }
}
