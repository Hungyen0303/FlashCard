import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoLocal.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChatWithAIViewModel extends ChangeNotifier {
  String nameOfConversation = "Conversation 1 ";

  final ChatWithAIRepo _repo = ChatWithAIRepoLocal();

  List<String> botChat = [];

  List<String> humanChat = [];

  bool isLoading = false;

  void setNameOfConversation(String name) {
    nameOfConversation = name;
  }

  Future<void> loadData() async {
    botChat = await _repo.loadBotChat(nameOfConversation);
    humanChat = await _repo.loadHumanChat(nameOfConversation);
    notifyListeners();
  }

  Future<bool> sendMessage(String text) async {
    humanChat.add(text);
    botChat.add("");
    notifyListeners();

    bool isSuccess = await _repo.sendMessage(text);
    if (isSuccess) {
      humanChat.removeAt(botChat.length - 2);
      botChat.removeAt(botChat.length - 2);
      notifyListeners();
    }
    return isSuccess;
  }
}
