import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoLocal.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoRemote.dart';
import 'package:flashcard_learning/domain/models/Conversation.dart';
import 'package:flashcard_learning/domain/models/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';

class ChatWithAIViewModel extends ChangeNotifier {
  final ChatWithAIRepo _repo = ChatWithAIRepoRemote();

  String nameOfConversation = "";
  List<Conversation> conversationList = [];
  int indexOfCurrentConversation = -1;

  List<Message> chatList = [];
  bool isLoading = false;

  String humanChat = '';

  String botChat = "";

  Future<void> setIndexOfConversation(int index) async {
    indexOfCurrentConversation = index;
    await loadChatList();
    notifyListeners();
  }

  Future<void> loadChatList() async {
    if (indexOfCurrentConversation != -1) {
      chatList = await _repo
          .getAllMessage(conversationList[indexOfCurrentConversation].id ?? "");
    } else {
      chatList = [];
    }

    notifyListeners();
  }

  Future<void> loadConversationList() async {
    conversationList = await _repo.getConversations();
    notifyListeners();
  }

  String API_KEY = "AIzaSyBax0qdrfE8U0TzsW4OISS4VZ3DqLic20s";

// TODO : Hide API_KEY
  Future<bool> saveMessage(String humanChat) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: API_KEY,
    );

    final content = [Content.text(humanChat)];
    final response = await model.generateContent(content);

    bool success = await _repo.saveMessage(
        Message(humanChat: humanChat, botChat: response.text ?? ""),
        conversationList[indexOfCurrentConversation].id ?? "");



    return true;
  }
}
