import 'package:flashcard_learning/data/repositories/auth/AuthRepositoryLocal.dart';
import 'package:flashcard_learning/data/repositories/auth/AuthRepositoryRemote.dart';
import 'package:flashcard_learning/data/services/supabass_service/SupabassService.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/auth/AppManager.dart';
import 'package:flashcard_learning/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flashcard_learning/ui/chat/view_models/ChatWithAIViewModel.dart';
import 'package:flashcard_learning/ui/dictionary/view_model/DictionaryViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomCardProvider.dart';
import 'package:flashcard_learning/ui/home/view_models/MainScreenViewModel.dart';
import 'package:flashcard_learning/ui/specific_flashcard/view_models/SpecificFlashCardViewModel.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'domain/models/user.dart';

void main() async {
  await Supabase.initialize(
    url: SupaBaseService.URL,
    anonKey: SupaBaseService.anonKey,
  );

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time}: [${record.level.name}] ${record.loggerName} - ${record.message}');
  });
  await AppManager.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CustomCardProvider>(
          create: (_) => CustomCardProvider()),
      Provider<AuthRepositoryRemote>(create: (_) => AuthRepositoryRemote()),
      ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(
              authRepository:
                  Provider.of<AuthRepositoryRemote>(context, listen: false))),
      ChangeNotifierProvider<FlashCardSetViewModel>(
          create: (_) => FlashCardSetViewModel()),
      ChangeNotifierProvider<SpecificFlashCardViewModel>(
          create: (_) => SpecificFlashCardViewModel()),
      ChangeNotifierProvider<ChatWithAIViewModel>(
          create: (_) => ChatWithAIViewModel()),
      ChangeNotifierProvider<AccountViewModel>(
          create: (_) => AccountViewModel()),
      ChangeNotifierProvider<MainScreenViewModel>(
          create: (_) => MainScreenViewModel()),
      Provider<DictionaryViewModel>(create: (context) => DictionaryViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Logger mainLogger = Logger("MyApp");

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.route,
      title: 'Learning with Flash Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "MainFont",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
