import 'package:flashcard_learning/data/services/api/api.dart';

abstract class DictionaryRepo {
  Future<String> getPopularWord();
}

class DictionaryRepoRemote extends DictionaryRepo {
  DictionaryRepoRemote({required this.api});
  final Api api;

  @override
  Future<String> getPopularWord() async {
    try {
      return await api.getPopularWord();
    } catch (e) {
      rethrow;
    }
  }
}
