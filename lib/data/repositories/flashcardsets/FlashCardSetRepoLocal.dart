import 'dart:math';

import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FlashCardSetRepoLocal extends FlashCardSetRepo {
  List<FlashCardSet> localListFlashCardSet = List.generate(3, (index) {
    List<IconData> iconData = [
      Icons.book,
      LineIcons.star,
      Icons.abc_outlined,
      Icons.account_circle_sharp,
      Icons.accessibility_new_rounded,
      Icons.add_alert_sharp,
      LineIcons.line,
      LineIcons.airFreshener
    ];
    Random random = Random();
    return FlashCardSet(
      DateTime.now().subtract(Duration(hours: random.nextInt(100))),
      "FlashCard Set $index",
      20,
      random.nextInt(100),
      iconData[random.nextInt(iconData.length - 1)],
      Colors.white,
    );
  });

  @override
  Future<List<FlashCardSet>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return localListFlashCardSet;
  }

  @override
  Future<bool> addNewSet(FlashCardSet newSet) async {
    await Future.delayed(const Duration(milliseconds: 500));
    localListFlashCardSet.add(newSet);
    return true;
  }

  @override
  Future<bool> updateSet(FlashCardSet newSet) async {
    await Future.delayed(Duration(microseconds: 500));
    return true;
  }

  @override
  Future<bool> deleteASet(String name) async {
    await Future.delayed(Duration(microseconds: 500));
    return true;
  }
}
