import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../data/repositories/chatWithAI/Prompt.dart';
import '../../../data/repositories/dictionary/DictionaryRepo.dart';
import '../../../data/repositories/dictionary/DictionaryRepoLocal.dart';
import '../../../data/services/api/dictionaryApi.dart';
import '../../../domain/models/Word.dart';
import '../../../domain/models/WordFromAPI.dart';

class DictionaryViewModel {
  DictionaryRepo repo = DictionaryRepoLocal();

  DictionaryApi dictionaryApi = DictionaryApi();

  Future<WordFromAPI> loadWord(String text) async {
    return await dictionaryApi.getWord(text);
  }

  Future<Word> getWord(String text) async {
    return await repo.getWord(text);
  }

  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: "AIzaSyBax0qdrfE8U0TzsW4OISS4VZ3DqLic20s",
  );

  List<String> popularWords = [];

  Future<List<String>> getPopularWord() async {
    if (popularWords.isEmpty) {
      String prompt = Prompt.promptForGettingPopularWord();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      String text = response.text ?? "";
      return text.split("%").toList();
    }
    return popularWords;
  }

  Future<Word> getWordFromApi(String text) async {
    return await repo.getWord(text);
  }
}
