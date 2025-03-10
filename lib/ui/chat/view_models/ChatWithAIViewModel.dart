import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoLocal.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChatWithAIViewModel extends ChangeNotifier {
  final ChatWithAIRepo _repo = ChatWithAIRepoLocal();
  String nameOfConversation = "";
  List<String> conversationList = [];

  List<String> chatList = [];

  bool isLoading = false;

  Future<void> setNameOfConversation(String name) async {
    nameOfConversation = name;
    await loadData();
  }

  Future<void> loadData() async {
    chatList = await _repo.loadChat(nameOfConversation);
    conversationList = await _repo.loadConversationList();
    notifyListeners();
  }

  Future<bool> sendMessage(String text) async {
    chatList
      ..add(text)
      ..add("");
    notifyListeners();

    bool isSuccess = await _repo.sendMessage(text, nameOfConversation);
    if (isSuccess) {
      chatList.removeAt(chatList.length - 4);
      chatList.removeAt(chatList.length - 3);
      notifyListeners();
    }
    return isSuccess;
  }
}
