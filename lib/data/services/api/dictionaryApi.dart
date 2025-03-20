import 'package:dio/dio.dart';
import 'package:flashcard_learning/domain/models/WordFromAPI.dart';

class DictionaryApi {
  final Dio dio = Dio();

  String baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  Future<WordFromAPI> getWord(String word) async {
    try {
      WordFromAPI wordFromAPI = WordFromAPI();
      Response res = await dio.get("${baseUrl}${word}");

      wordFromAPI.word = res.data[0]["word"] ?? "";
      wordFromAPI.linkAudio = res.data[0]["phonetics"][1]["audio"] ?? "";
      wordFromAPI.phonetics = res.data[0]["phonetics"][1]["text"] ?? "";

      for (var i in res.data[0]["meanings"]) {
        if (i["definitions"][0]["definition"] == null ||
            i["definitions"][0]["example"] == null) {
          continue;
        } else {
          Meaning meaning = Meaning.named(
            i["definitions"][0]["definition"] ,
            i["definitions"][0]["example"] ,
          );
          wordFromAPI.meanings.add(meaning);
          break;
        }
      }

      return wordFromAPI;
    } catch (e) {
      return WordFromAPI();
    }
  }
}
