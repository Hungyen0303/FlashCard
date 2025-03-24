import 'dart:math';

import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepoLocal.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/flashcardsets/FlashCardSetRepoRemote.dart';

class FlashCardSetViewModel extends ChangeNotifier {
  List<FlashCardSet> _listFlashCardSets = [];
  List<FlashCardSet> _listFlashCardSetsPublic = [];

  List<FlashCardSet> get listFlashCardSets => _listFlashCardSets;

  List<FlashCardSet> get listFlashCardSetsPublic => _listFlashCardSetsPublic;

  bool hasError = false;

  String errorMessage = " ";

  Future<bool> loadData() async {
    _listFlashCardSets = await getAllSet();
    _listFlashCardSetsPublic = await getAllSetPublic();
    notifyListeners();
    return true;
  }

  Future<void> checkDone(String nameOfSet, int numOfDone) async {
    int index = listFlashCardSets.indexWhere((e) => e.name == nameOfSet);
    if (numOfDone == _listFlashCardSets.length &&
        _listFlashCardSets[index].done != true) {
      _listFlashCardSets[index].done = true;
      FlashCardSet newSet = _listFlashCardSets[index];
      newSet.done = true;
      await _repo.editASet(newSet.name, newSet);
    }

    // if (numOfDone == _listFlashCardSets.length &&
    //     _listFlashCardSets[index].done != true) {
    //   _listFlashCardSets[index].done = true;
    //   FlashCardSet newSet = _listFlashCardSets[index];
    //   newSet.done = true;
    //   await _repo.editASet(newSet.name, newSet);
    // }
  }

  final FlashCardSetRepo _repo = FlashCardSetRepoRemote();

  Future<List<FlashCardSet>> getAllSet() async {
    try {
      return _repo.getAll();
    } catch (e) {
      return [];
    }
  }

  Future<List<FlashCardSet>> getAllSetPublic() async {
    try {
      return _repo.getAllSetPublic();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addNewSet(FlashCardSet newSet) async {
    try {
      await _repo.addNewSet(newSet);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> shareNewSet(FlashCardSet newSet) async {
    try {
      await _repo.addNewSetToPublic(newSet);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editASet(String name, FlashCardSet newSet) async {
    bool editedSuccessfully = await _repo.editASet(name, newSet);
    if (editedSuccessfully) {
      await loadData();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> deleteASet(String name) async {
    bool deletedSuccessfully = await _repo.deleteASet(name);
    if (deletedSuccessfully) {
      await loadData();
      notifyListeners();
      return true;
    }
    return false;
  }
}
