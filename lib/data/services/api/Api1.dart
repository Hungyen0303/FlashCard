import 'package:flashcard_learning/domain/models/Flashcard.dart';
import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/domain/models/user.dart';

import '../../../domain/models/Conversation.dart';
import '../../../domain/models/Message.dart';

/// API1 using spring boot for backend

abstract class Api1 {
  Future<void> login((String, String) credentials);

  Future<void> signUp((String, String, String) credentials);

  Future<void> getUser();

  Future<void> updateUser(User newUser);

  Future<void> verifyToken(String token, String refreshToken);

  Future<void> refresh();

  /*----------------Flashcard SET -----------------------*/

  Future<List<FlashCardSet>> getAllFlashcardSet();

  Future<List<FlashCardSet>> getAllFlashcardSetPublic();

  Future<bool> addNewSet(FlashCardSet f);

  Future<bool> updateSet(String flashcardName, FlashCardSet f);

  Future<bool> deleteSet(String name);

/*----------------Flashcard-----------------------*/
  Future<List<FlashCard>> getAllFlashcard(String name);

  Future<bool> addNewCard(FlashCard f, String nameOfSet);

  Future<bool> updateCard(FlashCard fOld, FlashCard fNew, String nameOfSet);

  Future<bool> deleteFlashcard(FlashCard f, String nameOfSet);

/*----------------Conversation -----------------------*/

  Future<List<Conversation>> getConversations();

  Future<Conversation> editConversation(
      Conversation c, String idOfConversation);

  Future<bool> deleteConversation(String idOfConversation);

  Future<Conversation> createConversation(Conversation c);

  Future<List<Message>> getAllMessage(String idOfConversation);

  Future<Message> saveMessage(Message newMessage, String idOfConversation);

  Future<Message> editMessage(
      Message newMessage, String idOfConversation, String idOfMessage);

/*----------------Tracking  -----------------------*/

  Future<Map<String, int>> getTrackData();
}
