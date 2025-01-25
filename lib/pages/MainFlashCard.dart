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
  final TextStyle styleOfList = TextStyle(
      color: MAIN_THEME_PURPLE_TEXT, fontSize: 20, fontWeight: FontWeight.w500);

  List<String> listTiles = [
    "Ôn lại từ trong flashcard ",
    "Thêm từ mới vào flashcard ",
    "Học flashcard của cộng đồng",
    "Giao tiếp với AI "
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
                          color: MAIN_THEME_PURPLE_TEXT,
                          fontSize: 25,
                          fontWeight: FontWeight.w500))
                ]),
              ),
              Aiconversation(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hôm nay chúng ta nên làm gì ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MAIN_THEME_PURPLE_TEXT,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  splashColor: Colors.red,
                  focusColor: Colors.blue,
                  iconColor: Colors.orange,
                  tileColor: Colors.grey[300],
                  trailing: Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orangeAccent]),
                        color: Colors.red,
                        shape: BoxShape.circle),
                  ),
                  onTap: () {},
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      LineIcons.book,
                      size: 34,
                    ),
                  ),
                  title: Container(
                    child: Text(
                      listTiles[0],
                      style: styleOfList,
                      maxLines: 2,
                      // Giới hạn số dòng
                      overflow: TextOverflow.ellipsis,
                      // Cắt bớt nếu vượt quá maxLines
                      softWrap: true, // Cho phép xuống dòng
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  textColor: MAIN_THEME_PURPLE_TEXT,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  splashColor: Colors.red,
                  focusColor: Colors.blue,
                  iconColor: Colors.orange,
                  tileColor: Colors.grey[300],
                  trailing: Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orangeAccent]),
                        color: Colors.red,
                        shape: BoxShape.circle),
                  ),
                  onTap: () {},
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      LineIcons.book,
                      size: 34,
                    ),
                  ),
                  title: Container(
                    child: Text(
                      listTiles[0],
                      style: styleOfList,
                      maxLines: 2,
                      // Giới hạn số dòng
                      overflow: TextOverflow.ellipsis,
                      // Cắt bớt nếu vượt quá maxLines
                      softWrap: true, // Cho phép xuống dòng
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  textColor: MAIN_THEME_PURPLE_TEXT,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  splashColor: Colors.red,
                  focusColor: Colors.blue,
                  iconColor: Colors.orange,
                  tileColor: Colors.grey[300],
                  trailing: Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orangeAccent]),
                        color: Colors.red,
                        shape: BoxShape.circle),
                  ),
                  onTap: () {},
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      LineIcons.book,
                      size: 34,
                    ),
                  ),


                  title: Container(
                    child: Text(
                      listTiles[0],
                      style: styleOfList,
                      maxLines: 2, // Giới hạn số dòng
                      overflow: TextOverflow.ellipsis, // Cắt bớt nếu vượt quá maxLines
                      softWrap: true, // Cho phép xuống dòng
                    ),
                  ),

                  contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  textColor: MAIN_THEME_PURPLE_TEXT,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  splashColor: Colors.red,
                  focusColor: Colors.blue,
                  iconColor: Colors.orange,
                  tileColor: Colors.grey[300],
                  trailing: Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orangeAccent]),
                        color: Colors.red,
                        shape: BoxShape.circle),
                  ),
                  onTap: () {},
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      LineIcons.book,
                      size: 34,
                    ),
                  ),


                  title: Container(
                    child: Text(
                      listTiles[0],
                      style: styleOfList,
                      maxLines: 2, // Giới hạn số dòng
                      overflow: TextOverflow.ellipsis, // Cắt bớt nếu vượt quá maxLines
                      softWrap: true, // Cho phép xuống dòng
                    ),
                  ),

                  contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  textColor: MAIN_THEME_PURPLE_TEXT,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
