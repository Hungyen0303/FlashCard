import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/services/AppInterceptor.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Status.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';

import '../../../domain/models/user.dart';
import '../../URL.dart';

Dio setupDio() {
  final dio = Dio();
  dio.interceptors.add(AppInterceptor(dio));
  return dio;
}

class Api1Impl extends Api1 {
  final Dio dio = setupDio();

  @override
  Future<void> login((String, String) credentials) async {
    final (username, password) = credentials;
    try {
      final response = await dio.post(
        URL.login,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["status"] == Status.success.value) {
          final token = response.data["data"]["token"] as String;
          final refreshToken = response.data["data"]["refreshToken"] as String;

          AppManager.saveToken(token, refreshToken);
          AppManager.setUser(
              User.fromJson(response.data["data"]["userInfoRes"]));
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUp((String, String, String) credentials) async {
    final (email, username, password) = credentials;
    try {
      final response = await dio.post(
        URL.signUp,
        data: {
          "email": email,
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(User newUser) async {
    try {
      final response = await dio.patch(URL.info,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${AppManager.getToken()}",
            },
          ),
          data: newUser.toJson());
      if (response.statusCode == 200) {
        AppManager.setUser(User.fromJson(response.data["data"]));
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> getUser() async {
    print("LOAD USER ") ;
    try {
      final response = await dio.get(
        URL.info,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}",
          },
        ),
      );
      if (response.statusCode == 200) {
        AppManager.setUser(User.fromJson(response.data["data"]));
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyToken(String token, String refreshToken) async {
    try {
      Response res = await dio.post(URL.verify,
          data: {"token": token, "refreshToken": refreshToken},
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ));
      if (res.statusCode == 200) {
        if (res.data["data"]["valid"]) {
          AppManager.saveToken(res.data["data"]["newToken"], refreshToken);
        } else {
          throw Exception(res.data["message"]);
        }
      }
    } on DioException catch (e) {}
  }

  @override
  Future<void> refresh() async {
    try {
      Response res = await dio.post(URL.refresh,
          options: Options(headers: {"Content-Type": "application/json"}),
          data: {"refreshToken": AppManager.getRefreshToken()});
      if (res.statusCode == 200) {
        AppManager.saveToken(
            res.data["data"]["token"], AppManager.getRefreshToken());
      }
    } on DioException catch (e) {}
  }
}
