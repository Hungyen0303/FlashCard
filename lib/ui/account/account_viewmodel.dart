import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/data/services/supabass_service/SupabassService.dart';
import 'package:flashcard_learning/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewModel(this._repo);

  final AccountRepository _repo;
  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> loadUser() async {
    _currentUser = await _repo.getUser() ?? User();
    notifyListeners();
  }

  bool countByDay = true;

  Future<void> changeAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        String linkAfterUploading =
            await SupaBaseService.uploadImageToSupabase(image.path, image.name);
        await _repo.updateUser(User.named(
            username: _currentUser?.username ?? '',
            name: _currentUser?.name ?? '',
            plan: _currentUser?.plan ?? '',
            avatar: linkAfterUploading));
        loadUser();
        notifyListeners();
      } catch (e) {
        // TODO : hasError and showError
      }
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    numOfCompleteFlashcard = -1;
    numOfCompleteConversation = -1;
  }

  Future<void> loadData() async {
    notifyListeners();
  }

  Future<void> setCountBy(bool isCountByDay) async {
    countByDay = isCountByDay;
    try {
      await loadData();
    } catch (e) {}

    notifyListeners();
  }

  Future<bool> updateName(String newName) async {
    try {
      await _repo.updateUser(User.named(
          username: _currentUser?.username ?? '',
          name: newName,
          plan: _currentUser?.plan ?? '',
          avatar: _currentUser?.avatar ?? ''));
      loadUser();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  int numOfCompleteFlashcard = -1;
  int numOfCompleteConversation = -1;

  void changeNumOfCompleteFlashcard(int change) {
    numOfCompleteFlashcard += change;
    notifyListeners();
  }

  Future<void> changeNumOfCompleteConversation() async {
    numOfCompleteConversation += 1;
    await _repo.postTrack();
    notifyListeners();
  }
}
