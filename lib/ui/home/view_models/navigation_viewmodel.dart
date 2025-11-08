import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flutter/cupertino.dart';

class NavigationViewModel extends ChangeNotifier {
  final Api1 api1;

  NavigationViewModel({required this.api1});

  int? currentIndex;
  bool tokenExpired = false;

  void verifyToken(String token, String refreshToken) {
    api1.verifyToken(token, refreshToken).then((value) {
      tokenExpired = !value;
      notifyListeners();
    });
  }

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
