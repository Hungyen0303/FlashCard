import 'package:flashcard_learning/AppCachedData.dart';
import 'package:flashcard_learning/AppProvider.dart';
import 'package:flashcard_learning/data/services/supabass_service/SupabassService.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'AppManager.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: SupaBaseService.URL,
    anonKey: SupaBaseService.anonKey,
  );
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time}: [${record.level.name}] ${record.loggerName} - ${record.message}');
  });
  await AppCachedData.initialize();
  await AppManager.initialize();
  runApp(MultiProvider(
    providers: AppProvider.providers,
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
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: darkBlue),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: darkBlue),
        useMaterial3: true,
      ),
    );
  }
}
