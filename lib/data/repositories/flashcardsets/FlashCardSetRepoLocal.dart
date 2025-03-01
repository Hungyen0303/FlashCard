import 'dart:math';

import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      LineIcons.airFreshener,
      FontAwesomeIcons.font,
    ];
    Random random = Random();
    return FlashCardSet(
      DateTime.now().subtract(Duration(hours: random.nextInt(100))),
      "FlashCard Set $index",
      20,
      random.nextInt(100),
      iconData[random.nextInt(iconData.length - 1)],
      Colors.green,
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
  Future<bool> editASet(FlashCardSet oldSet, FlashCardSet newSet) async {
    await Future.delayed(const Duration(milliseconds: 500));

    for (int i = 0; i < localListFlashCardSet.length; i++) {
      if (oldSet.name == localListFlashCardSet[i].name) {
        localListFlashCardSet[i].name = newSet.name;
        localListFlashCardSet[i].color = newSet.color;
        localListFlashCardSet[i].iconData = newSet.iconData;
        return true;
      }
    }

    return false;
  }

  @override
  Future<bool> deleteASet(String name) async {
    await Future.delayed(const Duration(microseconds: 500));
    FlashCardSet searchedItem =
        localListFlashCardSet.firstWhere((item) => item.name == name);
    localListFlashCardSet.remove(searchedItem);
    return true;
  }
}
