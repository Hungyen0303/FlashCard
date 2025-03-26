import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';

import '../../../domain/models/Flashcard.dart';

class SpecificFlashCardRepoRemote extends SpecificFlashCardRepo {
  List<FlashCard> cachedList = [];
  String nameOfSet = "";
  Api1 api1 = Api1Impl();

  @override
  void setNameOfSet(String newName) {
    nameOfSet = newName;
  }

  @override
  Future<List<FlashCard>> getAll(String nameOfSet) async {
    try {
      if (nameOfSet != this.nameOfSet) {
        cachedList = await api1.getAllFlashcard(nameOfSet);
        this.nameOfSet = nameOfSet;
      }
      return cachedList;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addNewCard(FlashCard flashcard) async {
    try {
      bool success = await api1.addNewCard(flashcard, nameOfSet);
      if (success) {
        cachedList.add(flashcard);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteACard(FlashCard card) async {
    try {
      bool success = await api1.deleteFlashcard(card, nameOfSet);
      if (success) {
        cachedList.remove(card);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editACard(FlashCard oldCard, FlashCard newCard) async {
    try {
      bool success = await api1.updateCard(oldCard, newCard, nameOfSet);
      if (success) {
        var index = cachedList.indexWhere((e) => oldCard == e);
        cachedList[index] = newCard;

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> markDone(int index) async {
    try {
      FlashCard oldFlashcard = cachedList[index];
      FlashCard newFlashcard = FlashCard(
        oldFlashcard.english,
        oldFlashcard.vietnamese,
        oldFlashcard.example,
      );
      newFlashcard.done = !oldFlashcard.done;
      bool success =
          await api1.updateCard(oldFlashcard, newFlashcard, nameOfSet);

      if (success) {
        cachedList[index] = newFlashcard;
      }

      return success;
    } catch (e) {
      print("Error in markDone: $e");
      return false;
    }
  }
}
