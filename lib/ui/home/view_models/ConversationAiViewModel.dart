import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoRemote.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/Prompt.dart';
import 'package:flashcard_learning/domain/models/Conversation.dart';
import 'package:flashcard_learning/domain/models/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ConversationAiViewModel extends ChangeNotifier {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: "AIzaSyBax0qdrfE8U0TzsW4OISS4VZ3DqLic20s",
  );

  String title = "";
  late Conversation currentConversation;
  List<String> questions = [];

  Future<void> loadQuestion(topic, level) async {
    String prompt = Prompt.promptsForGetQuestion(topic, level);
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    String question = response.text ?? "";
    question.split("%").forEach((e) {
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
      String prompt = Prompt.promptForLastQuestion(
          humanChat, questions[indexCurrentQuestion - 1]);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      Message responseMessage =
          Message(humanChat: humanChat, botChat: response.text ?? "");
      chatList.removeLast();
      chatList.add(responseMessage);
      isDone = true;
      averageScore /= 5;
    } else if (botChat.isEmpty) {
      chatList.add(Message(humanChat: humanChat, botChat: ""));
      notifyListeners();
      String prompt = Prompt.promptForGetScoreAndQuestion(humanChat,
          questions[indexCurrentQuestion], questions[indexCurrentQuestion + 1]);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      Message responseMessage =
          Message(humanChat: humanChat, botChat: response.text ?? "");

      try {
        double testValue = double.parse(response.text![7]);
        averageScore += testValue;
      } catch (e) {}

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
