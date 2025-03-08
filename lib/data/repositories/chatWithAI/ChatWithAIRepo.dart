

abstract class ChatWithAIRepo {
  Future<List<String>> loadBotChat(String nameOfConversation);
  Future<List<String>> loadHumanChat(String nameOfConversation);
  Future<bool> sendMessage(String message) ;
  Future<bool> getMessage(String message) ;


}