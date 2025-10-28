class URL {
  // static String baseURL = "http://192.168.1.10:8080/flashcard/api";
  static String baseURL =
      "https://flashcard.blackmushroom-b6cf5c98.southeastasia.azurecontainerapps.io/flashcard/api";

  /*-------------Auth-----------------*/

  static String login = "$baseURL/auth";
  static String signUp = "$baseURL/auth/registration";
  static String logout = "$baseURL/auth/logout";
  static String info = "$baseURL/info";
  static String verify = "$baseURL/auth/verify";
  static String refresh = "$baseURL/auth/refresh";

  /*-------------Flashcard-----------------*/

  static String flashCardSet = "$baseURL/FlashcardSet";
  static String flashCardSetPublic = "$baseURL/FlashcardSet/public";

  static String postFlashCardSetPublic(String name) =>
      "$baseURL/FlashcardSet/public/${name}";

  static String flashCard(nameOfSet) => "$baseURL/FlashcardSet/$nameOfSet";

  static String flashCardUpdateOrDelete(nameOfSet, id) =>
      "$baseURL/FlashcardSet/$nameOfSet/$id";

/*-------------Conversation-----------------*/

  static String conversationBase = "$baseURL/chat/conversations";

  static String getAllConversation = conversationBase;

  static String editConversation(id) => "$conversationBase/$id";

  static String createConversation() => conversationBase;

  static String deleteConversation(id) => "$conversationBase/$id";

  /*-------------Message -----------------*/

  static String getAllMessage(id) => "$conversationBase/$id";

  static String editMessage(idOfConversation, idOfMessage) =>
      "$conversationBase/$idOfConversation/$idOfMessage";

  static String createNewMessage(idOfConversation) =>
      "$conversationBase/$idOfConversation";

  static String track = "$info/track";
}
