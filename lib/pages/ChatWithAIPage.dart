import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../color/AllColor.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [Icon(Icons.line_style)],
          title: Text("Receive Plus version "),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SearchBar(
                controller: _searchController,
                leading: Icon(LineIcons.search),
                hintText: "Tìm kiếm",
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
            ListTile(
              tileColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: Icon(CupertinoIcons.plus),
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(),
                ),
              ),
              trailing: Icon(Icons.mic),
            )
          ],
        ));

  }
}
