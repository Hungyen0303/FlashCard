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

  Future<List<Word>> getPopularWord() async {
    return await repo.getPopularWord();
  }

  Future<Word> getWordFromApi(String text) async {
    return await repo.getWord(text);
  }
}
