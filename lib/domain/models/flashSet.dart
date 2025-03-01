import 'package:flutter/cupertino.dart';

class FlashCardSet {
  FlashCardSet(this.createAt, this.name, this.numberOfCard, this.minute,
      this.iconData, this.color);


  DateTime createAt;
  String name;
  int numberOfCard;
  int minute;
  IconData iconData;
  Color color;
}
