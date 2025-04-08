import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part "Flashcard.g.dart";

@JsonSerializable()
@HiveType(typeId: 0)
class FlashCard extends HiveObject{
  FlashCard(this.english, this.vietnamese, this.example);

  @HiveField(0)
  String id = "";

  @HiveField(1)
  final String vietnamese;

  @HiveField(2)
  final String english;

  @HiveField(3)
  final String example;

  @HiveField(4)
  bool done = false;

  factory FlashCard.fromJson(Map<String, dynamic> json) =>
      _$FlashCardFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardToJson(this);
}
