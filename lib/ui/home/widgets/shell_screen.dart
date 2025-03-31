import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/ui/account/account_screen.dart';
import 'package:flashcard_learning/ui/home/widgets/main_screen.dart';
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
      Mainflashcard(onTabChange: changeTab),
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
          // tab button ripple color when pressed
          hoverColor: Colors.grey,
          // tab button hover color
          haptic: true,
          // haptic feedback
          tabBorderRadius: 30,

          //tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
          //tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
          //tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
          curve: Curves.easeIn,
          // tab animation curves
          duration: const Duration(milliseconds: 50),
          // tab animation duration
          gap: 10,
          // the tab button gap between icon and text
          color: Colors.grey[800],
          // unselected icon color
          activeColor: textColor,
          // selected icon and text color
          iconSize: 24,
          // tab button icon size
          backgroundColor: Colors.white,
          tabBackgroundColor: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
          // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Homepage',
            ),
            GButton(
              icon: LineIcons.bookOpen,
              text: 'Dictionary',
            ),
            GButton(
              icon: LineIcons.facebookMessenger,
              text: 'Chat with AI',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            )
          ]),
      body: widgets[currentPageIndex],
    );
  }
}
