class URL {
  static String baseURL = "http://10.0.2.2:8080/flashcard/api";
  static String login = "$baseURL/auth";
  static String signUp = "$baseURL/auth/registration";
  static String logout = "$baseURL/auth/logout";
  static String info = "$baseURL/info";
  static String verify = "$baseURL/auth/verify";
  static String refresh = "$baseURL/auth/refresh";

  static String flashCardSet = "$baseURL/FlashcardSet";

  static String flashCard(nameOfSet) => "$baseURL/FlashcardSet/$nameOfSet";

  static String flashCardUpdateOrDelete(nameOfSet, id) => "$baseURL/FlashcardSet/$nameOfSet/$id";
}
