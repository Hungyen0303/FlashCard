import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/color/AllColor.dart';
import 'ConversationWidget.dart';

class ChatWithAIPage extends StatefulWidget {
  const ChatWithAIPage({super.key});

  @override
  State<ChatWithAIPage> createState() => _ChatWithAiPageState();
}

class _ChatWithAiPageState extends State<ChatWithAIPage> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ConversationWidget(),
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  bool isAsking = false;
  final TextEditingController _askingcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                LineIcons.newspaper,
                size: 28,
              ),
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Receive Plus version "),
              Icon(CupertinoIcons.plus_app , color: Colors.purple,)
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: MAIN_THEME_YELLOW,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: SearchBar(
                  onTap: () {
                    setState(() {
                      //  isSearch = true;
                    });
                  },
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      //isSearch = false;
                    });
                  },
                  controller: _searchController,
                  elevation: WidgetStateProperty.all(3.0),
                  shadowColor: WidgetStateProperty.all(
                      MAIN_THEME_PURPLE.withOpacity(0.2)),
                  side: WidgetStateProperty.all(
                    BorderSide(
                      color: MAIN_THEME_YELLOW_TEXT,
                      width: 1.2,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 2),
                    child: Icon(
                      LineIcons.search,
                      color: MAIN_THEME_YELLOW_TEXT,
                      size: 30.0,
                    ),
                  ),
                  hintText: "Tìm kiếm",
                  hintStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: MAIN_THEME_YELLOW_TEXT,
                      fontSize: 16.0,
                    ),
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: MAIN_THEME_PINK_TEXT,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    Colors.white.withOpacity(0.95),
                  ),
                  surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
                ),
              ),
              ListTile(
                onTap: () => _onItemTapped(0),
                title: Text("Conversation 1 "),
              ),
              ListTile(
                onTap: () => _onItemTapped(1),
                title: Text("Conversation 2 "),
              ),
              ListTile(
                onTap: () => _onItemTapped(2),
                title: Text("Conversation 3 "),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: ConversationWidget()),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
              decoration: BoxDecoration(
                boxShadow: [] ,
                border: Border(top: BorderSide(width: 2)),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    onTapOutside: (e) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _askingcontroller,
                    onTap: () {
                      setState(() {
                        isAsking = true;
                      });
                    },
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: 'Type your message...',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        CupertinoIcons.plus_circle_fill,
                        size: 25,
                        color: Color(0xffffbe29),
                      ),
                      Icon(
                        Icons.mic,
                        size: 25,
                        color: Color(0xffffbe29),
                      ),
                      Icon(
                        Icons.send,
                        size: 25,
                        color: Color(0xffffbe29),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
