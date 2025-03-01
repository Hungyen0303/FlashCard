import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardProvider extends ChangeNotifier {
  Color _iconColor = MAIN_THEME_BLUE;

  Color get iconColor => _iconColor; // Getter để đọc màu hiện tại

  IconData? _iconData = Icons.book;

  IconData? get iconData => _iconData; // Getter để đọc màu hiện tại

  void setIconData(IconData? iconData) {
    _iconData = iconData ;
    notifyListeners();
  }
  void setColor(Color color) {
    _iconColor = color ;
    notifyListeners();

  }


}
