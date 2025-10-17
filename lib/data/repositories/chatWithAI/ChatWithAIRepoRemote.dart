import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import '../../../domain/models/Conversation.dart';
import '../../../domain/models/Message.dart';

class ChatWithAIRepoRemote extends ChatWithAIRepo {
  List<Conversation> cachedConversation = [];

  ChatWithAIRepoRemote({required this.api});

  final Api api;

  @override
  Future<List<Conversation>> getConversations() async {
    if (cachedConversation.isEmpty) {
      cachedConversation = await api.getConversations();
    }
    return cachedConversation;
  }

  @override
  Future<bool> editConversation(Conversation c, String idOfConversation) async {
    await api.editConversation(c, idOfConversation);
    return true;
  }

  @override
  Future<bool> deleteConversation(String idOfConversation) async {
    await api.deleteConversation(idOfConversation);
    return true;
  }

  @override
  Future<Conversation> createConversation(Conversation c) async {
    Conversation newC = await api.createConversation(c);
    return newC;
  }

  @override
  Future<List<Message>> getAllMessage(String idOfConversation) async {
    return await api.getAllMessage(idOfConversation);
  }

  @override
  Future<bool> saveMessage(Message newMessage, String idOfConversation) async {
    await api.saveMessage(newMessage, idOfConversation);
    return true;
  }

  @override
  Future<bool> editMessage(
      Message newMessage, String idOfConversation, String idOfMessage) async {
    await api.editMessage(newMessage, idOfConversation, idOfMessage);
    return true;
  }
}
