import 'package:hive_flutter/hive_flutter.dart';

enum RepoName {
  account("Account"),
  auth("Auth"),
  chatWithAi("ChatWithAi"),
  flashcardSet("FlashcardSet"),
  specificCards("SpecificFlashcard");

  final String name;

  const RepoName(this.name);
}

class AppCachedData {
  static List<String> listRepo = [
    RepoName.account.name,
    RepoName.auth.name,
    RepoName.chatWithAi.name,
    RepoName.flashcardSet.name,
    RepoName.specificCards.name,
  ];

  static Future<void> initialize() async {
    await Hive.initFlutter();
  }

  static Future<void> clearCachedData() async {
    listRepo.forEach((e) async {
      await Hive.box(e).clear();
    });
  }
}
