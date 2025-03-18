import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Status.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';

import '../../../domain/models/user.dart';
import '../../URL.dart';

class Api1Impl extends Api1 {
  final Dio dio = Dio();

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
              "Authorization":
                  "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJodW5neWVuIiwic3ViIjoidXNlcjMiLCJleHAiOjE3NDIyODQ5NDksImlhdCI6MTc0MjI4MTM0OSwic2NvcGUiOiJyZWZyZXNoVG9rZW4ifQ.FlSYdAqp8SBk-JJHIUW0tlHII33Bl05w7FIfE47R9hFsd_yCbQ4E4a1-Rk3dxrRw-WhUKr3RrZFtoeTa_Tbr_g",
              // Thêm Bear
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
    try {
      final response = await dio.get(
        URL.info,
        options: Options(
          headers: {
            "Content-Type": "application/json",
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
}
