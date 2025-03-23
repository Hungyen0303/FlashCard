
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class IconDataConverter implements JsonConverter<IconData, int> {
  const IconDataConverter();

  @override
  IconData fromJson(int json) => IconData(json, fontFamily: 'MaterialIcons');

  @override
  int toJson(IconData icon) => icon.codePoint;
}