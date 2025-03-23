// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashSet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashCardSet _$FlashCardSetFromJson(Map<String, dynamic> json) => FlashCardSet(
      json['name'] as String,
      (json['numOfCard'] as num).toInt(),
      const IconDataConverter().fromJson((json['iconData'] as num).toInt()),
      const ColorConverter().fromJson((json['color'] as num).toInt()),
      json['done'] as bool,
    );

Map<String, dynamic> _$FlashCardSetToJson(FlashCardSet instance) =>
    <String, dynamic>{
      'name': instance.name,
      'numOfCard': instance.numOfCard,
      'iconData': const IconDataConverter().toJson(instance.iconData),
      'color': const ColorConverter().toJson(instance.color),
      'done': instance.done,
    };
