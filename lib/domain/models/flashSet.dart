import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/ColorConverter.dart';

part 'flashSet.g.dart';

@JsonSerializable()
class FlashCardSet {
  FlashCardSet(this.name, this.numOfCard, this.iconData, this.color, this.done);
  String name;
  int numOfCard;
  int iconData;
  @ColorConverter()
  Color color;

  bool done;

  factory FlashCardSet.fromJson(Map<String, dynamic> json) =>
      _$FlashCardSetFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardSetToJson(this);
}
