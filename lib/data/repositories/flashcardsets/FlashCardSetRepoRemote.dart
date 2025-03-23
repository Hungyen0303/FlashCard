import 'dart:math';

import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

import '../../services/api/Api1.dart';

class FlashCardSetRepoRemote extends FlashCardSetRepo {
  List<FlashCardSet> cachedlocalListFlashCardSet = [];

  List<FlashCardSet> cachedlocalListFlashCardSetPublic = [];

  Api1 api1 = Api1Impl();

  @override
  Future<bool> addNewSetToPublic(FlashCardSet newSet) async {
    // localListFlashCardSetPublic.add(newSet);
    return true;
  }

  @override
  Future<List<FlashCardSet>> getAllSetPublic() async {
    try {
      if (cachedlocalListFlashCardSetPublic.isEmpty) {
        cachedlocalListFlashCardSetPublic =
            await api1.getAllFlashcardSetPublic();
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
        cachedlocalListFlashCardSet = await api1.getAllFlashcardSet();
      }
      return cachedlocalListFlashCardSet;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addNewSet(FlashCardSet newSet) async {
    try {
      bool success = await api1.addNewSet(newSet);
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
      bool success = await api1.updateSet(nameOfSet, newSet);
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
      bool success = await api1.deleteSet(name);
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
