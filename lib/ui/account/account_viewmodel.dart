
import 'package:flashcard_learning/data/repositories/account/AccountRepositorylocal.dart';
import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewModel();

  AccountRepository _repo = AccountRepositoryLocal();
  Future<void> pickImageLocal() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {

      notifyListeners();
    }
  }
}
