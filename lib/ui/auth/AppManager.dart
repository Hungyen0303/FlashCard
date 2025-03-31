import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:flashcard_learning/domain/models/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../routing/route.dart';

class AppManager {
  static String _token = "";

  static String _refreshToken = "";
  static User? _currentUser = User();
  static late SharedPreferences prefs;

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

  /// if there are no token => login
  /// if token is still valid => auto login
  /// if token is not valid => refresh =>auto login
  /// if both is not valid => login
  ///

  static final Api1 _api1 = Api1Impl();

  static Future<bool> isLogged() async {
    if (_token.isEmpty) {
      return false;
    } else {
      try {
        await _api1.verifyToken(_token, _refreshToken);
        return true;
      } on Exception catch (e) {
        return false;
      }
    }
  }

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("isFirstTime");

    loadToken();

    firstRoute = await getInitialRoute();
    if (firstRoute == AppRoute.home) {
      await loadUser();
    }
  }

  static Future<String> getInitialRoute() async {
    if (prefs.getBool("isFirstTime") == null) {
      await prefs.setBool("isFirstTime", true);
      return AppRoute.boarding;
    }
    if (await isLogged()) return AppRoute.home;
    return AppRoute.login;
  }

  static User? getUser() {
    return _currentUser;
  }

  static Future<void> loadUser() async {
    try {
      await _api1.getUser();
    } on DioException catch (e) {
    } on Exception catch (e) {
      print("message" + e.toString());
    }
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
    setUser(User());
  }
}
