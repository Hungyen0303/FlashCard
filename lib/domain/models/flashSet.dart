import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/ColorConverter.dart';
import '../converters/IconDataConverter.dart';

part 'flashSet.g.dart';

@JsonSerializable()
class FlashCardSet {
  FlashCardSet(
      this.name, this.numOfCard, this.iconData, this.color, this.done);

  // DateTime createAt;
  String name;

  int numOfCard;

  // TODO : CHECK AGAIN Converter
  @IconDataConverter()
  IconData iconData;

  // TODO : CHECK AGAIN Converter

  @ColorConverter()
  Color color;

  bool done;

  factory FlashCardSet.fromJson(Map<String, dynamic> json) =>
      _$FlashCardSetFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardSetToJson(this);
}
