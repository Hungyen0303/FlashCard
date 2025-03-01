import 'package:flashcard_learning/data/repositories/dictionary/DictionaryRepo.dart';
import 'package:flashcard_learning/domain/models/Word.dart';

class DictionaryRepoLocal extends DictionaryRepo {
  @override
  Future<Word> getWord(String text) async {
    await Future.delayed(Duration(seconds: 1));
    return Word(
        "xin chào",
        "hello ",
        "/hello/",
        "A common greeting used to express a friendly or polite acknowledgement",
        "When meeting someone , it is customary to say 'hello' as a form of greeting",
        "audio");
  }

  @override
  Future<List<Word>> getPopularWord() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      Word(
          "xin chào",
          "Cleaning the house",
          "/hello/",
          "A common greeting used to express a friendly or polite acknowledgement",
          "When meeting someone , it is customary to say 'hello' as a form of greeting",
          "audio"),
      Word(
          "Refresh",
          "Refresh ",
          "/hello/",
          "A common greeting used to express a friendly or polite acknowledgement",
          "When meeting someone , it is customary to say 'hello' as a form of greeting",
          "audio"),
      Word(
          "xin chào",
          "Putting up decoration  ",
          "/hello/",
          "A common greeting used to express a friendly or polite acknowledgement",
          "When meeting someone , it is customary to say 'hello' as a form of greeting",
          "audio"),
      Word(
          "xin chào",
          " Beat around the bush ",
          "/hello/",
          "A common greeting used to express a friendly or polite acknowledgement",
          "When meeting someone , it is customary to say 'hello' as a form of greeting",
          "audio"),
    ];
  }
}
