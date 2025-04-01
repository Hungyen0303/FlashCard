import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../routing/route.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    context.go(AppRoute.login);
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset(
      'assets/$assetName',
      width: width,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        pages: [
          PageViewModel(
            title: "Unlock Your English Potential!",
            body: "Learn faster with interactive flashcards designed for your success.",
            image: _buildImage('img-1.jpg'),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18.0,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
              imagePadding: const EdgeInsets.only(bottom: 24),
              pageColor: Colors.transparent,
            ),
          ),
          PageViewModel(
            title: "Turn Words Into Knowledge!",
            body: "Discover the power of consistent practice and effortless learning.",
            image: _buildImage('img-2.jpg'),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18.0,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
              imagePadding: const EdgeInsets.only(bottom: 24),
              pageColor: Colors.transparent,
            ),
          ),
          PageViewModel(
            title: "Master English, One Card at a Time!",
            body: "Your path to fluency starts here—take the first step today.",
            image: _buildImage('img-1.jpg'),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 18.0,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
              imagePadding: const EdgeInsets.only(bottom: 24),
              pageColor: Colors.transparent,
            ),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        next: Icon(
          Icons.arrow_forward,
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
        done: Text(
          'Get Started',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: isDarkMode ? Colors.grey[600]! : Colors.grey[400]!,
          activeSize: const Size(22.0, 10.0),
          activeColor: theme.primaryColor,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        dotsContainerDecorator: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25.0),
        ),
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: const EdgeInsets.all(12),
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}