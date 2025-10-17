class AppRoute {



  static String home = '/home';
  static String splash = '/splash';

  static String login = '/login';

  static String signup = '/signup';
  static String upgrade = '/upgrade';

  static String boarding = '/boarding';

  static String forgetpassword = '/forgetpassword';

  static String flashCardSet = '/flashcardSet/:name';

  static String gotoFlashcardSet(String name , String isPublic ) => '/flashcardSet?name=$name&isPublic=${isPublic.toString()}';

  static String SearchByImagePath = '/searchbyimage';

  static String profile = "/profile";

  static String public_flashcard = '/flashcard-public';
}
