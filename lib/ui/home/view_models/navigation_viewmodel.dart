import 'package:flashcard_learning/data/services/api/api.dart';
import 'package:flutter/cupertino.dart';

class NavigationViewModel extends ChangeNotifier {
  final Api api;

  NavigationViewModel({required this.api});

  int? currentIndex;
  bool tokenExpired = false;

  void verifyToken(String token, String refreshToken) {
    api.verifyToken(token, refreshToken).then((value) {
      tokenExpired = !value;
      notifyListeners();
    });
  }

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
