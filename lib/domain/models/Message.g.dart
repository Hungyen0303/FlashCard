// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      humanChat: json['humanChat'] as String?,
      botChat: json['botChat'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'humanChat': instance.humanChat,
      'botChat': instance.botChat,
    };
