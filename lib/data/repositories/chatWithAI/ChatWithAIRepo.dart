import '../../../domain/models/Conversation.dart';
import '../../../domain/models/Message.dart';

abstract class ChatWithAIRepo {
  Future<List<Conversation>> getConversations();

  Future<bool> editConversation(Conversation c, String idOfConversation);

  Future<bool> deleteConversation(String idOfConversation);

  Future<bool> createConversation(Conversation c);

  Future<List<Message>> getAllMessage(String idOfConversation);

  Future<bool> saveMessage(Message newMessage, String idOfConversation);

  Future<bool> editMessage(
      Message newMessage, String idOfConversation, String idOfMessage);
}
