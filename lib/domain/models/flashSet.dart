import 'package:flutter/cupertino.dart';

class FlashCardSet {
  FlashCardSet(
      this.createAt, this.name, this.numberOfCard, this.minute, this.iconData, this.color);

  final DateTime createAt;
  final String name;
  final int numberOfCard;
  final int minute;
  final IconData iconData  ;
  final Color color ;

}
