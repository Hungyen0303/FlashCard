import 'package:flashcard_learning/AppProvider.dart';
import 'package:flashcard_learning/l10n/app_localizations.dart';
import 'package:flashcard_learning/routing/router.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/utils/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'AppManager.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await AppManager.initialize();
  runApp(MultiProvider(
    providers: AppProvider.providers,
    child: const RequestsInspector(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
      return SafeArea(
        child: MaterialApp.router(
          locale: localeProvider.locale,
          routerConfig: AppRouter.route,
          title: 'Learning with Flash Card',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            fontFamily: "MainFont",
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: darkBlue),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: darkBlue),
            useMaterial3: true,
          ),
        ),
      );
    });
  }
}
