import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoRemote.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/Prompt.dart';
import 'package:flashcard_learning/domain/models/Conversation.dart';
import 'package:flashcard_learning/domain/models/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatWithAIViewModel extends ChangeNotifier {
  final ChatWithAIRepo _repo = ChatWithAIRepoRemote();

  // TODO : has Error
  // TODO Error message
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
    if (indexOfCurrentConversation == -1) {
      indexOfCurrentConversation = conversationList.length;
      Conversation newC =
          Conversation(name: "New Conversation $indexOfCurrentConversation");
      conversationList.add(newC);
      indexOfCurrentConversation = conversationList.length - 1;
      notifyListeners();
      conversationList[indexOfCurrentConversation] =
          await _repo.createConversation(newC);
    }

    chatList.add(Message(humanChat: humanChat, botChat: ""));
    notifyListeners();
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: API_KEY,
    );

    String prompt = Prompt.getPromptForChat();
    String finalContent = prompt + ". Content is " + humanChat;

    final content = [Content.text(finalContent)];
    final response = await model.generateContent(content);
    Message responseMessage =
        Message(humanChat: humanChat, botChat: response.text ?? "");

    bool success = await _repo.saveMessage(
        responseMessage, conversationList[indexOfCurrentConversation].id ?? "");

    chatList.removeLast();
    chatList.add(responseMessage);
    notifyListeners();

    return true;
  }

  Future<bool> editConversation(int index, Conversation newConversation) async {
    bool success = await _repo.editConversation(
        newConversation, conversationList[index].id ?? "");
    if (success) {
      conversationList[index].name = newConversation.name;
    }
    notifyListeners();
    return success;
  }

  Future<bool> deleteConversation(int index) async {
    if (index == indexOfCurrentConversation) {
      indexOfCurrentConversation = -1;
      notifyListeners();
    }
    bool success =
        await _repo.deleteConversation(conversationList[index].id ?? "");
    conversationList.removeAt(index);
    notifyListeners();
    return success;
  }

// Future<bool> editMessage(int index, Message newMessage) async {
//   bool success = await _repo.editMessage(newMessage ,
//     conversationList[index].id ?? "" ,   );
//   return success;
// }
}
