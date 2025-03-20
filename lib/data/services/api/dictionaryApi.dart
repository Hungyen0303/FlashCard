import 'package:dio/dio.dart';

class DictionaryApi {
  final Dio dio = Dio();

  String baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  Future<Response> getWord(String word) async {
    return await dio.get("${baseUrl}word");
  }
}
