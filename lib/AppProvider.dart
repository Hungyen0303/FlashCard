import 'package:flashcard_learning/data/repositories/account/AccountRepositoryRemote.dart';
import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoRemote.dart';
import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepoRemote.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepoRemote.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flashcard_learning/ui/chat/view_models/ChatWithAIViewModel.dart';
import 'package:flashcard_learning/ui/dictionary/view_model/DictionaryViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomCardProvider.dart';
import 'package:flashcard_learning/ui/home/view_models/MainScreenViewModel.dart';
import 'package:flashcard_learning/ui/specific_flashcard/view_models/SpecificFlashCardViewModel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'data/repositories/auth/AuthRepositoryRemote.dart';
import 'data/services/api/Api1.dart';
import 'data/services/api/Api1Impl.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<CustomCardProvider>(
        create: (_) => CustomCardProvider()),


    Provider<AuthRepositoryRemote>(create: (_) => AuthRepositoryRemote()),
    ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(
            authRepository:
                Provider.of<AuthRepositoryRemote>(context, listen: false))),


    Provider<FlashCardSetRepo>(create: (_) => FlashCardSetRepoRemote()),
    ChangeNotifierProvider<FlashCardSetViewModel>(
        create: (context) => FlashCardSetViewModel(
            Provider.of<FlashCardSetRepo>(context, listen: false))),


    Provider<SpecificFlashCardRepo>(create: (_) => SpecificFlashCardRepoRemote()),
    ChangeNotifierProvider<SpecificFlashCardViewModel>(
        create: (context) => SpecificFlashCardViewModel(
          Provider.of<SpecificFlashCardRepo>(context , listen:  false ) )),

    Provider<ChatWithAIRepo>(create: (_) => ChatWithAIRepoRemote()),
    ChangeNotifierProvider<ChatWithAIViewModel>(
        create: (context) => ChatWithAIViewModel(
          Provider.of<ChatWithAIRepo>(context, listen: false)
        )),

    Provider<AccountRepository>(create: (_) => AccountRepositoryRemote()),
    ChangeNotifierProvider<AccountViewModel>(create: (context) => AccountViewModel(
      Provider.of<AccountRepository>(context )
    )),


    ChangeNotifierProvider<MainScreenViewModel>(
        create: (_) => MainScreenViewModel()),



    Provider<DictionaryViewModel>(create: (context) => DictionaryViewModel()),
  ];
}
