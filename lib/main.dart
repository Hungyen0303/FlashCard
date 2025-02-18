import 'package:flashcard_learning/ui/home/widgets/onboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Learning with Flash Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "MainFont",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoardingPage () ,
    );
  }
}

