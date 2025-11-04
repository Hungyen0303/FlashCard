import 'package:flashcard_learning/data/repositories/homepage/home_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/models/Conversation.dart';
import '../../../domain/models/Message.dart';

class MainScreenViewModel extends ChangeNotifier {
  List<String> conversation = [];

  final HomeRepo repo;
  MainScreenViewModel({required this.repo});

  Function()? onDoneChanged;

  bool hasError = false;

  String messageErrors = "";

  Future<void> getListConversation() async {
    if (conversation.isNotEmpty) return;
    String response = await repo.getTopics();
    response.split(",").forEach((e) {
      conversation.add(e.trim());
    });
  }

  String title = "";
  late Conversation currentConversation;
  List<String> questions = [];

  Future<void> loadQuestion(topic, level) async {
    final response = await repo.getQuestionFromAI(topic, level);
    response.split("%").forEach((e) {
      questions.add(e);
    });
  }

  double averageScore = 0.0;

  void clear() {
    questions.clear();
    chatList.clear();
    indexCurrentQuestion = -1;
    isDone = false;
    averageScore = 0;
  }

  List<Message> chatList = [];

  bool isDone = false;
  int indexCurrentQuestion = -1;

  Future<void> initialize(String title, String level) async {
    this.title = title;
    await loadQuestion(title, level);
    saveMessage("Let's get started", questions[0]);
  }

  Future<bool> saveMessage(String humanChat, String botChat) async {
    if (indexCurrentQuestion == 4) {
      chatList.add(Message(humanChat: humanChat, botChat: ""));
      notifyListeners();

      final String response = await repo.generateLastQuestion(
          humanChat, questions[indexCurrentQuestion - 1]);
      Message responseMessage =
          Message(humanChat: humanChat, botChat: response);
      chatList.removeLast();
      chatList.add(responseMessage);
      isDone = true;
      averageScore /= 5;
      onDoneChanged?.call();
    } else if (botChat.isEmpty) {
      chatList.add(Message(humanChat: humanChat, botChat: ""));
      notifyListeners();
      final String response = await repo.generateScoreAndQuestion(humanChat,
          questions[indexCurrentQuestion], questions[indexCurrentQuestion + 1]);
      Message responseMessage =
          Message(humanChat: humanChat, botChat: response);

      try {
        double testValue = double.parse(response[8]);
        averageScore += testValue;
      } catch (e) {
        averageScore += 5;
      }

      chatList.removeLast();
      chatList.add(responseMessage);
    } else {
      chatList.add(Message(humanChat: humanChat, botChat: botChat));
    }
    indexCurrentQuestion += 1;
    notifyListeners();
    return true;
  }
}
