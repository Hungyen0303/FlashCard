import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';
import 'package:flashcard_learning/data/services/api/Api1Impl.dart';

import '../../../domain/models/Conversation.dart';
import '../../../domain/models/Message.dart';

/*Initially I use two array for saving human chat and bot chat , but now i
* change a bit , use one array , combine two of them , and human chat first
* */

class ChatWithAIRepoRemote extends ChatWithAIRepo {
  Map<String, List<String>> fakeDbLocal = {
    "Conversation 1": [
      "Hello, can I ask you some questions?",
      "Sure, go ahead.",
      "How to use this word \"ephemeral\"?",
      "It's a word that means something lasting for a short time.",
      "Can you give an example of using \"ephemeral\"?",
      "Sure, it can be used in a sentence like: 'The beauty of the sunset was ephemeral.'",
      "Thanks for the explanation!",
      "You're welcome!"
    ],
    "Conversation 2": [
      "Hi there, can I ask you something?",
      "Of course, what do you want to know?",
      "What does the word \"serendipity\" mean?",
      "It means finding something good without looking for it.",
      "Can you use it in a sentence?",
      "Sure! 'Meeting you was a wonderful serendipity.'",
      "That's interesting, thanks!",
      "No problem!"
    ],
    "Conversation 3": [
      "Hey, do you have a moment?",
      "Yes, I do. What’s up?",
      "How do you use the word \"quintessential\"?",
      "It refers to the most perfect or typical example of a quality or class.",
      "Can you show me how to use it?",
      "Absolutely! 'She is the quintessential student.'",
      "Got it, thanks for your help!",
      "Happy to help!"
    ],
  };

  List<Conversation> cachedConversation = [];

  Api1 api1 = Api1Impl();

  @override
  Future<List<Conversation>> getConversations() async {
    if (cachedConversation.isEmpty) {
      cachedConversation = await api1.getConversations();
    }
    return cachedConversation;
  }

  @override
  Future<bool> editConversation(Conversation c, String idOfConversation) async {
    await api1.editConversation(c, idOfConversation);
    return true;
  }

  @override
  Future<bool> deleteConversation(String idOfConversation) async {
    await api1.deleteConversation(idOfConversation);
    return true;
  }

  @override
  Future<Conversation> createConversation(Conversation c) async {
    Conversation newC = await api1.createConversation(c);
    return newC;
  }

  @override
  Future<List<Message>> getAllMessage(String idOfConversation) async {
    return await api1.getAllMessage(idOfConversation);
  }

  @override
  Future<bool> saveMessage(Message newMessage, String idOfConversation) async {
    await api1.saveMessage(newMessage, idOfConversation);
    return true;
  }

  @override
  Future<bool> editMessage(
      Message newMessage, String idOfConversation, String idOfMessage) async {
    await api1.editMessage(newMessage, idOfConversation, idOfMessage);
    return true;
  }
}
