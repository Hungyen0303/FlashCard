import '../../../data/repositories/dictionary/DictionaryRepo.dart';
import '../../../data/repositories/dictionary/DictionaryRepoLocal.dart';
import '../../../domain/models/Word.dart';

class DictionaryViewModel {
  DictionaryRepo repo = DictionaryRepoLocal();

  Future<Word> getWord(String text) async {
    return await repo.getWord(text);
  }

  Future<List<Word>> getPopularWord() async {
    return await repo.getPopularWord();
  }
}
