// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Flashcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashCard _$FlashCardFromJson(Map<String, dynamic> json) => FlashCard(
      json['english'] as String,
      json['vietnamese'] as String,
      json['example'] as String,
      json['id'] as String,
    );

Map<String, dynamic> _$FlashCardToJson(FlashCard instance) => <String, dynamic>{
      'id': instance.id,
      'vietnamese': instance.vietnamese,
      'english': instance.english,
      'example': instance.example,
    };
