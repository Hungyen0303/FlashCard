import 'package:json_annotation/json_annotation.dart';

part "Conversation.g.dart";

@JsonSerializable()
class Conversation {
  Conversation({required this.name});

  String? id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;


  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
