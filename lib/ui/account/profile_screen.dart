import 'package:flashcard_learning/MainAppUser.dart';
import 'package:flashcard_learning/main.dart';
import 'package:flashcard_learning/routing/route.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/ui/auth/login/widgets/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  int _index = 0;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Container buildActions(Icon icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xffe8a90e), borderRadius: BorderRadius.circular(10)),
      child: IconTheme(
          data: IconThemeData(
            color: Color(0xFF6200EE),
          ),
          child: icon),
    );
  }

  TextStyle textStyle = TextStyle(color: MAIN_THEME_BLUE_TEXT);
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: Colors.grey[500],
  );

  AppBar _buildAppbar() {
    return AppBar(
      leading: Icon(
        Icons.navigate_before,
        color: Color(0xFF6200EE),
      ),
      title: Text(
        "Profile",
        style: TextStyle(color: MAIN_THEME_BLUE_TEXT),
      ),
      centerTitle: true,
      actions: [
        buildActions(Icon(LineIcons.lightningBolt)),
        buildActions(Icon(LineIcons.fire)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: Container());
  }
}
