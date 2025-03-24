import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/services/AppInterceptor.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Status.dart';
import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';

import '../../../domain/models/flashSet.dart';
import '../../../domain/models/user.dart';
import '../../URL.dart';

Dio setupDio() {
  final dio = Dio();
  dio.interceptors.add(AppInterceptor(dio));

  // TODO : Test
  Options options = Options(sendTimeout: Duration(seconds: 10));
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
    print("LOAD USER ");
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

  @override
  Future<List<FlashCardSet>> getAllFlashcardSet() async {
    try {
      String token = AppManager.getToken();
      Response res = await dio.get(URL.flashCardSet,
          options: Options(headers: {
            "Authorization": "Bearer ${AppManager.getToken()}",
            "Content-Type": "application/json"
          }));
      List<dynamic> rawData = res.data["data"];
      return rawData.map((e) => FlashCardSet.fromJson(e)).toList();
    } on DioException catch (e) {
      return [];
    }
  }

  @override
  Future<List<FlashCardSet>> getAllFlashcardSetPublic() async {
    try {
      String token = AppManager.getToken();
      Response res = await dio.get(URL.flashCardSet,
          options: Options(headers: {
            "Authorization": "Bearer ${AppManager.getToken()}",
            "Content-Type": "application/json"
          }));
      List<dynamic> rawData = res.data["data"];
      return rawData.map((e) => FlashCardSet.fromJson(e)).toList();
    } on DioException catch (e) {
      return [];
    }
  }

  @override
  Future<bool> addNewSet(FlashCardSet f) async {
    try {
      Response res = await dio.post(URL.flashCardSet,
          data: f.toJson(),
          options: Options(headers: {
            "Authorization": "Bearer ${AppManager.getToken()}",
            "Content-Type": "application/json"
          }));
      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } on DioException catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateSet(String flashcardName, FlashCardSet f) async {
    try {
      Response res = await dio.patch("${URL.flashCardSet}/$flashcardName",
          data: f.toJson(),
          options: Options(headers: {
            "Authorization": "Bearer ${AppManager.getToken()}",
            "Content-Type": "application/json"
          }));
      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } on DioException catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteSet(String name) async {
    try {
      Response res = await dio.delete("${URL.flashCardSet}/$name",
          options: Options(headers: {
            "Authorization": "Bearer ${AppManager.getToken()}",
            "Content-Type": "application/json"
          }));
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      return false;
    }
  }

  @override
  Future<bool> addNewCard(FlashCard f, String nameOfSet) async {
    try {
      // String encodedName = Uri.encodeComponent(nameOfSet);
      // print(encodedName);

      Response res = await dio.post(URL.flashCard(nameOfSet),
          data: f.toJson(),
          options: Options(headers: {
            "Authorization": "Bearer ${AppManager.getToken()}",
            "Content-Type": "application/json"
          }));
      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } on DioException catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteFlashcard(FlashCard f, String nameOfSet) async {
    try {
      Response res =
          await dio.delete(URL.flashCardUpdateOrDelete(nameOfSet, f.id),
              options: Options(headers: {
                "Authorization": "Bearer ${AppManager.getToken()}",
                "Content-Type": "application/json"
              }));
      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } on DioException catch (e) {
      return false;
    }
  }

  @override
  Future<List<FlashCard>> getAllFlashcard(String name) async {
    try {
      Response res = await dio.get(URL.flashCard(name),
          options: Options(headers: {
            "Authorization": "Bearer ${AppManager.getToken()}",
            "Content-Type": "application/json"
          }));
      if (res.statusCode == 200) {
        List<dynamic> rawData = res.data["data"];
        return rawData.map((e) => FlashCard.fromJson(e)).toList();
      } else
        return [];
    } on DioException catch (e) {
      return [];
    }
  }

  @override
  Future<bool> updateCard(
      FlashCard fOld, FlashCard fNew, String nameOfSet) async {
    try {
      String url = URL.flashCardUpdateOrDelete(nameOfSet, fOld.id);
      Response res =
          await dio.patch(URL.flashCardUpdateOrDelete(nameOfSet, fOld.id),
              data: fNew.toJson(),
              options: Options(headers: {
                "Authorization": "Bearer ${AppManager.getToken()}",
                "Content-Type": "application/json"
              }));
      if (res.statusCode == 200) {
        return true;
      } else
        return false;
    } on DioException catch (e) {
      return false;
    }
  }
}
