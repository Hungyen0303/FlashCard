import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/ui/account/account_screen.dart';
import 'package:flashcard_learning/ui/home/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../chat/widgets/chatwithAI_screen.dart';
import '../../dictionary/view_model/DictionaryViewModel.dart';
import '../../dictionary/widget/dictionary_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> widgets = [];
  int currentPageIndex = 0;

  void changeTab(int tab) {
    setState(() {
      currentPageIndex = tab;
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
        dictionaryViewModel: DictionaryViewModel(),
      ),
      const ChatWithAIPage(),
      const AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
      body: widgets[currentPageIndex],
    );
  }
}
