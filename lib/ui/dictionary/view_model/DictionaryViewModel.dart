import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../AppManager.dart';
import '../../../data/repositories/dictionary/DictionaryRepo.dart';
import '../../../data/services/api/dictionaryApi.dart';
import '../../../domain/models/Word.dart';
import '../../../domain/models/WordFromAPI.dart';

class DictionaryViewModel {
  DictionaryViewModel({required this.repo});
  final DictionaryRepo repo;
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

  List<String> popularWords = [];

  Future<List<String>> getPopularWord() async {
    if (popularWords.isEmpty) {
      final response = await repo.getPopularWord();
      popularWords = response.split("%%").toList();
      popularWords.removeLast();
    }
    return popularWords;
  }
}
