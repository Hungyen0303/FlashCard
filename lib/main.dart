import 'package:flashcard_learning/data/repositories/auth/AuthRepositoryLocal.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/ui/flashcard_sets/widgets/CustomCardProvider.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'domain/models/user.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time}: [${record.level.name}] ${record.loggerName} - ${record.message}');
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CustomCardProvider>(
          create: (_) => CustomCardProvider()),
      Provider<Authrepositorylocal>(create: (_) => Authrepositorylocal()),
      Provider<LoginViewModel>(
          create: (context) => LoginViewModel(
              authRepository:
                  Provider.of<Authrepositorylocal>(context, listen: false))),
      ChangeNotifierProvider<FlashCardSetViewModel>(
          create: (_) => FlashCardSetViewModel()),
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
