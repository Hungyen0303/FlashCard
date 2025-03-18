
import 'dart:typed_data';

import 'package:flashcard_learning/domain/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  static String? _token;
  static String? _refreshToken;
  static User? _currentUser = User();

  static void setUser(User u) {
    _currentUser?.name = u.name;
    _currentUser?.avatar = u.avatar;
    _currentUser?.plan = u.plan;
  }

  static User? getUser() {
    return _currentUser;
  }



  static Future<void> saveToken(String token, String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = token;
    _refreshToken = refreshToken;
    await prefs.setString("token", token);
    await prefs.setString("refreshToken", refreshToken);
  }

  static Future<void> loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    _refreshToken = prefs.getString("refreshToken");
  }

  Future<void> clearToken(String token, String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("refreshToken");
  }
}
