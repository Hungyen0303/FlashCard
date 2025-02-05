import 'package:flashcard_learning/color/AllColor.dart';
import 'package:flashcard_learning/pages/AccountPage.dart';
import 'package:flashcard_learning/pages/DictionaryPage.dart';
import 'package:flashcard_learning/pages/MainFlashCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'ChatWithAIPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> widgets = [Mainflashcard(), Dictionarypage()  ,  ChatWithAIPage(), Accountpage()];
  int currentPageIndex = 0;


  List<Color> color_bg_btn = [MAIN_THEME_PURPLE_TEXT , MAIN_THEME_PURPLE ,
    MAIN_THEME_PINK_TEXT , MAIN_THEME_PINK ,
    MAIN_THEME_YELLOW_TEXT , MAIN_THEME_YELLOW ,
    MAIN_THEME_BLUE_TEXT, MAIN_THEME_BLUE ,

  ] ;

  Color textColor =  MAIN_THEME_PURPLE_TEXT ;
  Color bgColor = MAIN_THEME_PURPLE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        onTabChange: (tab) {
          setState(() {
            currentPageIndex =  tab  ;
            bgColor = color_bg_btn[tab *2  + 1] ;
            textColor = color_bg_btn[tab * 2 ] ;
          });
        },
          rippleColor: Colors.grey, // tab button ripple color when pressed
          hoverColor: Colors.grey, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 50,

          //tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
          //tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
          //tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
          curve: Curves.easeIn, // tab animation curves
          duration: Duration(milliseconds: 50), // tab animation duration
          gap: 10, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: textColor, // selected icon and text color
          iconSize: 24, // tab button icon size
          backgroundColor : Colors.white ,
          tabBackgroundColor: bgColor ,
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17), // navigation bar padding
          tabs: [
            GButton(

              icon: LineIcons.home,
              text: 'Home',
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
          ]
      ) ,
      body: widgets[currentPageIndex],
    );
  }
}


