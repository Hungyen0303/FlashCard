import 'dart:async';

import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepoRemote.dart';
import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flutter/cupertino.dart';

class SpecificFlashCardViewModel extends ChangeNotifier {
  final SpecificFlashCardRepo _repo = SpecificFlashCardRepoRemote();
  List<FlashCard> flashcardList = [];
  late int numOfDone;
   Function(int)? onDoneChanged;
  late final VoidCallback? onAllDone;
  Timer? _debounceTimer;

  Future<void> loadData(String nameOfSet) async {
    await getAll(nameOfSet);
    calculateNumOfDone();
  }

  void calculateNumOfDone() {
    numOfDone = 0;
    flashcardList.forEach((i) {
      if (i.done) numOfDone++;
    });
  }

  Future<void> markDone(int index) async {
    onDoneChanged?.call(flashcardList[index].done ? -1 : 1);

    flashcardList[index].done = !flashcardList[index].done;
    calculateNumOfDone();
    notifyListeners();

    if (numOfDone == flashcardList.length) {
      onAllDone?.call();
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () async {
      try {
        bool success = await _repo.markDone(index);
        if (!success) {
          flashcardList[index].done = !flashcardList[index].done;
          calculateNumOfDone();
          onDoneChanged?.call(flashcardList[index].done ? 1 : -1);
          notifyListeners();
        }
      } catch (e) {
        print("Error syncing markDone: $e");
        flashcardList[index].done = !flashcardList[index].done;
        calculateNumOfDone();
        onDoneChanged?.call(flashcardList[index].done ? 1 : -1);
        notifyListeners();
      }
    });
  }

  Future<bool> getAll(String nameOfSet) async {
    flashcardList = await _repo.getAll(nameOfSet);
    notifyListeners();
    return true;
  }

  Future<bool> addACard(FlashCard newCard, String nameOfSet) async {
    try {
      bool success = await _repo.addNewCard(newCard);
      flashcardList = await _repo.getAll(nameOfSet);
      if (success) {
        await getAll(nameOfSet);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editACard(
      FlashCard oldCard, FlashCard newCard, String name) async {
    try {
      bool success = await _repo.editACard(oldCard, newCard);
      flashcardList = await _repo.getAll(name);
      if (success) {
        getAll(name);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteACard(FlashCard card, String name) async {
    try {
      if (card.done) numOfDone--;
      bool success = await _repo.deleteACard(card);
      if (success) {
        flashcardList = await _repo.getAll(name);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
