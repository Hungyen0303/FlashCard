import 'package:flashcard_learning/data/repositories/account/AccountRepositoryRemote.dart';
import 'package:flashcard_learning/data/repositories/account/accountRepository.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepo.dart';
import 'package:flashcard_learning/data/repositories/chatWithAI/ChatWithAIRepoRemote.dart';
import 'package:flashcard_learning/data/repositories/dictionary/DictionaryRepo.dart';
import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepo.dart';
import 'package:flashcard_learning/data/repositories/flashcardsets/FlashCardSetRepoRemote.dart';
import 'package:flashcard_learning/data/repositories/homepage/home_repo.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepo.dart';
import 'package:flashcard_learning/data/repositories/specific_flashcard/SpecificFlashCardRepoRemote.dart';
import 'package:flashcard_learning/data/services/api/api.dart';
import 'package:flashcard_learning/data/services/api/api_impl.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flashcard_learning/ui/chat/view_models/ChatWithAIViewModel.dart';
import 'package:flashcard_learning/ui/dictionary/view_model/DictionaryViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomCardProvider.dart';
import 'package:flashcard_learning/ui/home/view_models/MainScreenViewModel.dart';
import 'package:flashcard_learning/ui/home/view_models/navigation_viewmodel.dart';
import 'package:flashcard_learning/ui/specific_flashcard/view_models/SpecificFlashCardViewModel.dart';
import 'package:flashcard_learning/utils/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'data/repositories/auth/AuthRepositoryRemote.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<CustomCardProvider>(
        create: (_) => CustomCardProvider()),
    Provider<Api>(create: (_) => ApiImpl()),
    Provider<HomeRepo>(
        create: (context) =>
            HomeRepo(api: Provider.of<Api>(context, listen: false))),
    Provider<DictionaryRepo>(
        create: (context) => DictionaryRepoRemote(
            api: Provider.of<Api>(context, listen: false))),
    ChangeNotifierProvider<NavigationViewModel>(
        create: (context) =>
            NavigationViewModel(api: Provider.of<Api>(context, listen: false))),
    Provider<AuthRepositoryRemote>(
        create: (_) =>
            AuthRepositoryRemote(api: Provider.of<Api>(_, listen: false))),
    ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(
            authRepository:
                Provider.of<AuthRepositoryRemote>(context, listen: false))),
    Provider<FlashCardSetRepo>(
        create: (_) =>
            FlashCardSetRepoRemote(api: Provider.of<Api>(_, listen: false))),
    ChangeNotifierProvider<FlashCardSetViewModel>(
        create: (context) => FlashCardSetViewModel(
            Provider.of<FlashCardSetRepo>(context, listen: false))),
    Provider<SpecificFlashCardRepo>(
        create: (context) => SpecificFlashCardRepoRemote(
            api: Provider.of<Api>(context, listen: false))),
    ChangeNotifierProvider<SpecificFlashCardViewModel>(
        create: (context) => SpecificFlashCardViewModel(
            Provider.of<SpecificFlashCardRepo>(context, listen: false))),
    Provider<ChatWithAIRepo>(
        create: (context) => ChatWithAIRepoRemote(
            api: Provider.of<Api>(context, listen: false))),
    ChangeNotifierProvider<ChatWithAIViewModel>(
        create: (context) => ChatWithAIViewModel(
            Provider.of<ChatWithAIRepo>(context, listen: false))),
    Provider<AccountRepository>(
        create: (context) => AccountRepositoryRemote(
            api: Provider.of<Api>(context, listen: false))),
    ChangeNotifierProvider<AccountViewModel>(
        create: (context) => AccountViewModel(
            Provider.of<AccountRepository>(context, listen: false))),
    ChangeNotifierProvider<MainScreenViewModel>(
        create: (context) => MainScreenViewModel(
              repo: Provider.of<HomeRepo>(context, listen: false),
            )),
    Provider<DictionaryViewModel>(
        create: (context) => DictionaryViewModel(
              repo: Provider.of<DictionaryRepo>(context, listen: false),
            )),
    ChangeNotifierProvider<LocaleProvider>(
        create: (context) => LocaleProvider()),
  ];
}
