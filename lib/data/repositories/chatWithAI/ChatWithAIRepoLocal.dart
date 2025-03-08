import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';

class ChatWithAIRepoLocal extends ChatWithAIRepo {
  // Fake database
  List<String> botChat = [
    "Sure , go ahead ",
    "It's a word , mean something lasting in short time",
    "Sure , go ahead , which word you want to add  ",
    "Sure , go",
  ];

  List<String> humanChat = [
    "alo , can i ask you some question",
    "How to use this word \"ephermeral\" go ahead ",
    "How to use this word \"ephermeral\" go ",
    "Sure , go ahead ",
  ];

  @override
  Future<List<String>> loadBotChat(String nameOfConversation) async {
    await Future.delayed(Duration(milliseconds: 500));
    return botChat;
  }

  @override
  Future<List<String>> loadHumanChat(String nameOfConversation) async {
    await Future.delayed(Duration(milliseconds: 500));
    return humanChat;
  }

  @override
  Future<bool> sendMessage(String message) async {
    bool isSuccess = await getMessage(message);
    if (isSuccess) {
      humanChat.add(message);
    }

    return isSuccess;
  }

  @override
  Future<bool> getMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    String res = "Sure , this is .... ";
    botChat.add(res);

    // api call service

    return true;
  }
}
