import 'dart:ui';

import 'package:flashcard_learning/domain/models/user.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../routing/route.dart';

class AppManager {
  static String _token = "";
  static String _refreshToken = "";
  static Locale? _locale;
  static User? _currentUser = User();
  static late SharedPreferences prefs;
  static Future<void> setLocale(Locale locale) async {
    await prefs.setString("locale", locale.languageCode);
  }

  static get locale => _locale;

  static void setUser(User u) {
    _currentUser?.name = u.name;
    _currentUser?.avatar = u.avatar;
    _currentUser?.plan = u.plan;
  }

  static String getToken() {
    return _token;
  }

  static String getRefreshToken() {
    return _refreshToken;
  }

  static String firstRoute = AppRoute.boarding;

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    loadToken();
    firstRoute = await getInitialRoute();
  }

  static Future<String> getInitialRoute() async {
    if (prefs.getBool("isFirstTime") == null) {
      await prefs.setBool("isFirstTime", true);
      return AppRoute.boarding;
    }
    _locale = Locale(prefs.getString("locale") ?? "en");
    if (getToken().isEmpty) {
      return AppRoute.login;
    } else {
      return AppRoute.home;
    }
  }

  static User? getUser() {
    return _currentUser;
  }

  static Future<void> saveToken(String token, String refreshToken) async {
    _token = token;
    _refreshToken = refreshToken;
    await prefs.setString("token", token);
    await prefs.setString("refreshToken", refreshToken);
  }

  static void loadToken() {
    _token = prefs.getString("token") ?? "";
    _refreshToken = prefs.getString("refreshToken") ?? "";
  }

  static Future<void> clearToken() async {
    try {
      await prefs.remove("token");
      await prefs.remove("refreshToken");
    } catch (e) {}
  }

  static Future<void> logout() async {
    await clearToken();
    _token = "";
    _refreshToken = "";
    setUser(User());
  }
}
