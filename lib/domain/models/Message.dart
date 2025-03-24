import 'package:json_annotation/json_annotation.dart';

part 'Message.g.dart';

@JsonSerializable()
class Message {
  Message({this.humanChat, this.botChat});

  String? id;
  String? humanChat;
  String? botChat;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
