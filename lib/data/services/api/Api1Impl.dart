import 'package:dio/dio.dart';
import 'package:flashcard_learning/data/services/AppInterceptor.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Status.dart';
import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';

import '../../../domain/models/Conversation.dart';
import '../../../domain/models/Message.dart';
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

  @override
  Future<Message> editMessage(
      Message newMessage, String idOfConversation, String idOfMessage) async {
    try {
      Response res = await dio.post(
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}"
          }),
          URL.editMessage(idOfConversation, idOfMessage),
          data: newMessage.toJson());
      if (res.statusCode == 200) {
        return Message.fromJson(res.data["data"]);
      }
      return Message();
    } on DioException catch (e) {
      return Message();
    }
  }

  @override
  Future<Message> saveMessage(
      Message newMessage, String idOfConversation) async {
    try {
      Response res = await dio.post(URL.createNewMessage(idOfConversation),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}"
          }),
          data: newMessage.toJson());
      if (res.statusCode == 200) {
        return Message.fromJson(res.data["data"]);
      }
      return Message();
    } on DioException catch (e) {
      return Message();
    }
  }

  @override
  Future<List<Message>> getAllMessage(String idOfConversation) async {
    try {
      Response res = await dio.get(URL.getAllMessage(idOfConversation),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}"
          }));
      if (res.statusCode == 200) {
        List<dynamic> rawData = res.data["data"];
        return rawData.map((e) => Message.fromJson(e)).toList();
      }
      return [];
    } on DioException catch (e) {
      return [];
    }
  }

  @override
  Future<Conversation> createConversation(Conversation c) async {
    try {
      Response res = await dio.post(
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}"
          }),
          URL.createConversation(),
          data: c.toJson());
      if (res.statusCode == 200) {
        return Conversation.fromJson(res.data["data"]);
      }
      return Conversation(name: 'null');
    } on DioException catch (e) {
      return Conversation(name: 'null');
    }
  }

  @override
  Future<bool> deleteConversation(String idOfConversation) async {
    try {
      Response res = await dio.delete(
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppManager.getToken()}"
        }),
        URL.deleteConversation(idOfConversation),
      );
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      return false;
    }
  }

  @override
  Future<Conversation> editConversation(
      Conversation c, String idOfConversation) async {
    try {
      Response res = await dio.patch(
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}"
          }),
          URL.editConversation(idOfConversation),
          data: c.toJson());
      if (res.statusCode == 200) {
        return Conversation.fromJson(res.data["data"]);
      }
      return Conversation(name: "null");
    } on DioException catch (e) {
      return Conversation(name: "null");
    }
  }

  @override
  Future<List<Conversation>> getConversations() async {
    try {
      Response res = await dio.get(URL.getAllConversation,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}"
          }));
      if (res.statusCode == 200) {
        List<dynamic> rawData = res.data["data"];
        return rawData.map((e) => Conversation.fromJson(e)).toList();
      }
      return [];
    } on DioException catch (e) {
      return [];
    }
  }

/*---------------------------Tracking --------------------------*/
  @override
  Future<Map<String, int>> getTrackData() async {
    try {
      Response res = await dio.get(URL.track,
          options: Options(headers: {
            'Content-Type': "application/json",
            "Authorization": "Bearer ${AppManager.getToken()}"
          }));

      if (res.statusCode == 200) {
        Map<String, dynamic> rawData = res.data["data"];
        Map<String, int> parsedData = {};

        rawData.forEach((key, value) {
          if (value is int) {
            parsedData[key] = value;
          } else {
            parsedData[key] =  -1 ;
          }
        });

        return parsedData;
      } else {
        return {
          "flashcard": -1,
          "conversation": -1,
        };
      }
    } on DioException catch (e) {
      return {
        "flashcard": -1,
        "conversation": -1,
      };
    }
  }
}
