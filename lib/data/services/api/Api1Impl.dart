import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Status.dart';

import '../../URL.dart';

class Api1Impl extends Api1 {
  final Dio dio = Dio();

  @override
  Future<String> login((String, String) credentials) async {
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
          return token;
        } else {
          final error = response.data["error"]["message"] as String;
          return error;
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
}
