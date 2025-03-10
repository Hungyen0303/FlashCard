abstract class ChatWithAIRepo {
  Future<List<String>> loadChat(String nameOfConversation);

  Future<List<String>> loadConversationList();

  Future<bool> sendMessage(String message, String nameOfConversation);

  Future<bool> getMessage(String message, String nameOfConversation);
}
