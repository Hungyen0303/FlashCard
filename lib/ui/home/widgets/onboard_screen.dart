import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/utils/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLanguageSelectionDialog(context);
    });
  }

  void showLanguageSelectionDialog(BuildContext context) {
    final provider = context.read<LocaleProvider>();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Select Language'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Image.asset('assets/vietnam.png', width: 35),
                    title: const Text('Tiếng Việt'),
                    onTap: () {
                      provider.setLocale(const Locale('vi'));
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/us.png', width: 35),
                    title: const Text('English'),
                    onTap: () {
                      provider.setLocale(const Locale('en'));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
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
            title: context.l10n.onboarding_title_1,
            body: context.l10n.onboarding_body_1,
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
            title: context.l10n.onboarding_title_2,
            body: context.l10n.onboarding_body_2,
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
            title: context.l10n.onboarding_title_3,
            body: context.l10n.onboarding_body_3,
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
          context.l10n.onboarding_skip,
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
          context.l10n.onboarding_get_started,
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
