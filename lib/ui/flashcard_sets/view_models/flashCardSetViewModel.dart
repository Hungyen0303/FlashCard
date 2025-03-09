import 'dart:math';

import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepoLocal.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

class FlashCardSetViewModel extends ChangeNotifier {
  FlashCardSetViewModel() {
    loadData();
  }

  List<FlashCardSet> _listFlashCardSets = [];
  List<FlashCardSet> _listFlashCardSetsPublic = [];

  List<FlashCardSet> get listFlashCardSets => _listFlashCardSets;
  List<FlashCardSet> get listFlashCardSetsPublic => _listFlashCardSetsPublic;

  Future<bool> loadData() async {
    _listFlashCardSets = await getAllSet();
    _listFlashCardSetsPublic = await getAllSetPublic();
    notifyListeners();
    return true;
  }

  final FlashCardSetRepo _repo = FlashCardSetRepoLocal();


  Future<List<FlashCardSet>> getAllSet() async {
    return _repo.getAll();
  }

  Future<List<FlashCardSet>> getAllSetPublic() async {
    return _repo.getAllSetPublic();
  }

  Future<bool> addNewSet(FlashCardSet newSet) async {
    bool addedSuccessfully = await _repo.addNewSet(newSet);
    if (addedSuccessfully) {
      notifyListeners();
      return true;
    }
    return false;
  }
  Future<bool> shareNewSet(FlashCardSet newSet) async {
    bool addedSuccessfully = await _repo.addNewSetToPublic(newSet);
    if (addedSuccessfully) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> editASet(FlashCardSet oldSet, FlashCardSet newSet) async {
    bool editedSuccessfully = await _repo.editASet(oldSet, newSet);
    if (editedSuccessfully) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> deleteASet(String name) async {
    bool deletedSuccessfully = await _repo.deleteASet(name);
    if (deletedSuccessfully) {
      notifyListeners();
      return true;
    }
    return false;
  }
}
