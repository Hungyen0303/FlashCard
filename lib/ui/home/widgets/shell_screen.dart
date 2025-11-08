import 'package:flashcard_learning/AppManager.dart';
import 'package:flashcard_learning/data/repositories/dictionary/DictionaryRepo.dart';
import 'package:flashcard_learning/data/services/api/api.dart';
import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/ui/account/account_viewmodel.dart';
import 'package:flashcard_learning/ui/home/view_models/navigation_viewmodel.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/ui/account/account_screen.dart';
import 'package:flashcard_learning/ui/home/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../chat/widgets/chat_with_ai_screen.dart';
import '../../dictionary/view_model/DictionaryViewModel.dart';
import '../../dictionary/widget/dictionary_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  List<Widget> widgets = [];
  bool _dialogShown = false;

  void changeTab(int tab) {
    setState(() {
      final navVM = context.read<NavigationViewModel>();
      navVM.changeIndex(tab);
    });
  }

  Color textColor = Color(0xFFE2E6EA);
  Color bgColor = darkBlue;

  @override
  void initState() {
    super.initState();
    widgets = [
      HomePage(onTabChange: changeTab),
      DictionaryPage(
        dictionaryViewModel: DictionaryViewModel(
            repo: Provider.of<DictionaryRepo>(context, listen: false)),
      ),
      const ChatWithAIPage(),
      const AccountPage(),
    ];
    final navVM = context.read<NavigationViewModel>();
    context.read<AccountViewModel>().loadUser();

    navVM.addListener(() {
      if (navVM.tokenExpired) {
        AppManager.clearToken();
        if (_dialogShown) return; // <-- prevent multiple dialogs
        _dialogShown = true;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 32),
              titlePadding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_clock_rounded,
                        size: 35,
                        color: Colors.redAccent.shade200,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        context.l10n.session_expired,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.please_login_again,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 5, end: 0),
                    duration: const Duration(seconds: 5),
                    builder: (context, value, child) {
                      return Text(
                        "${value.toInt()}s...",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.redAccent.shade200,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );

        Future.delayed(const Duration(seconds: 5), () {
          if (!context.mounted) return;
          Navigator.of(context).pop();
          context.go(AppRoute.login);
        });
      }
    });

    navVM.verifyToken(AppManager.getToken(), AppManager.getRefreshToken());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, navVM, child) {
        return Scaffold(
          bottomNavigationBar: GNav(
              onTabChange: (tab) {
                changeTab(tab);
              },
              rippleColor: Colors.grey,
              hoverColor: Colors.grey,
              haptic: true,
              tabBorderRadius: 30,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 50),
              gap: 10,
              color: Colors.grey[800],
              activeColor: textColor,
              iconSize: 24,
              backgroundColor: Colors.white,
              tabBackgroundColor: bgColor,
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: context.l10n.nav_home,
                ),
                GButton(
                  icon: LineIcons.bookOpen,
                  text: context.l10n.nav_dictionary,
                ),
                GButton(
                  icon: LineIcons.facebookMessenger,
                  text: context.l10n.nav_chat_with_ai,
                ),
                GButton(
                  icon: LineIcons.user,
                  text: context.l10n.nav_profile,
                )
              ]),
          body: widgets[navVM.currentIndex ?? 0],
        );
      },
    );
  }
}
