import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/domain/models/Word.dart';

abstract class DictionaryRepo {
  Future<String> getPopularWord();
}

class DictionaryRepoRemote extends DictionaryRepo {
  DictionaryRepoRemote({required this.api1});
  final Api1 api1;

  @override
  Future<String> getPopularWord() async {
    try {
      return await api1.getPopularWord();
    } catch (e) {
      rethrow;
    }
  }
}
