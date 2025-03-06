class AppRoute {
  static String home = '/home';

  static String login = '/login';

  static String signup = '/signup';

  static String boarding = '/boarding';

  static String forgetpassword = '/forgetpassword';

  static String flashCardSet = '/flashcardSet/:name';

  static String gotoFlashcardSet(String name) => '/flashcardSet/$name';

  static String SearchByImagePath = '/searchbyimage';
}
