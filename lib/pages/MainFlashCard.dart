import 'package:flashcard_learning/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/AIConversation.dart';

class Mainflashcard extends StatefulWidget {
  const Mainflashcard({super.key});

  @override
  State<Mainflashcard> createState() => _MainflashcardState();
}

class _MainflashcardState extends State<Mainflashcard> {
  String nameUser = "Người dùng khách ";
  Color bg_color = Color(0xFFebdfee);

  List<ListTile> listTiles = [
    ListTile(
      leading: Icon(LineIcons.addressBook),
      title: Text("Luyện tập bài học hằng ngày "),
      trailing: Icon(LineIcons.ad),
    ),
    ListTile(
      leading: Icon(LineIcons.addressBook),
      title: Text("Luyện tập bài học hằng ngày "),
      trailing: Icon(LineIcons.ad),
    ),
    ListTile(
      leading: Icon(LineIcons.addressBook),
      title: Text("Luyện tập bài học hằng ngày "),
      trailing: Icon(LineIcons.ad),
    ),
    ListTile(
      leading: Icon(LineIcons.addressBook),
      title: Text("Luyện tập bài học hằng ngày "),
      trailing: Icon(LineIcons.ad),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFebdfee),
      appBar: AppBar(
        leading: Icon(
          LineIcons.userShield,
          color: Colors.red,
        ),
        actions: [
          Icon(Icons.fireplace_sharp),
          Icon(Icons.lightbulb_circle),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Chào mừng bạn trở lại, \n",
                      style: TextStyle(
                          color: MAIN_THEME_PURPLE_TEXT, fontSize: 18)),
                  TextSpan(
                      text: nameUser,
                      style: TextStyle(
                          color: MAIN_THEME_PURPLE_TEXT, fontSize: 25,
                      fontWeight: FontWeight.w500))
                ]),
              ),

              Aiconversation(),
              Text("Hôm nay chúng ta nên làm gì "),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: listTiles.length,
                  itemBuilder: (context, index) {
                    return listTiles[index];
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
