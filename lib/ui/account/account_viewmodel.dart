import 'package:flashcard_learning/data/repositories/account/AccountRepositorylocal.dart';
import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewModel();

  AccountRepository _repo = AccountRepositoryLocal();

  User user = User();

  Future<void> pickImageLocal() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _repo.setImage(image!.path);
      user.avatarPath = image!.path;
      notifyListeners();
    }
  }
}
