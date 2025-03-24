import 'package:json_annotation/json_annotation.dart';

part "Flashcard.g.dart";

@JsonSerializable()
class FlashCard {
  FlashCard(this.english, this.vietnamese, this.example);

  String id = "";

  final String vietnamese;

  final String english;

  final String example;

  bool done = false;

  factory FlashCard.fromJson(Map<String, dynamic> json) =>
      _$FlashCardFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardToJson(this);
}
