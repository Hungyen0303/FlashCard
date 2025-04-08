import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../AppManager.dart';
import '../../../data/repositories/chatWithAI/Prompt.dart';
import '../../../data/repositories/dictionary/DictionaryRepo.dart';
import '../../../data/repositories/dictionary/DictionaryRepoLocal.dart';
import '../../../data/services/api/dictionaryApi.dart';
import '../../../domain/models/Word.dart';
import '../../../domain/models/WordFromAPI.dart';

class DictionaryViewModel {
  DictionaryRepo repo = DictionaryRepoLocal();

  bool hasError = false;

  String errorMessage = "";

  DictionaryApi dictionaryApi = DictionaryApi();

  Future<WordFromAPI?> loadWord(String text) async {
    try {
      return await dictionaryApi.getWord(text);
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
      return null;
    }
  }

  Future<Word> getWord(String text) async {
    return await repo.getWord(text);
  }
  final model = AppManager.getAI();
  List<String> popularWords = [];

  Future<List<String>> getPopularWord() async {
    if (popularWords.isEmpty) {
      String prompt = Prompt.promptForGettingPopularWord();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      String text = response.text ?? "";
      popularWords = text.split("%").toList();
      popularWords.removeLast();
    }
    return popularWords;
  }

  Future<Word> getWordFromApi(String text) async {
    return await repo.getWord(text);
  }
}
