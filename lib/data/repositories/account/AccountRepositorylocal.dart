import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';

class AccountRepositoryLocal extends AccountRepository {
  // Local path
  String pathOfImage = "";
  String plan = "Basic";

  @override
  void setImage(String path) {
    pathOfImage = path;
  }
}
