import 'package:flashcard_learning/domain/models/Word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Searchresultpage extends StatelessWidget {
  Searchresultpage({super.key, required this.word});

  final Word word;

  void getText() {}

  Padding _buildText(String text, TextStyle? style) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: style,
      ),
    );
  }

  TextStyle mainWord = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  TextStyle submain = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: GestureDetector(
            child: Icon(Icons.navigate_before),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(word.english, mainWord),
                  _buildText(word.phonetic, null),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.volume_down,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        CupertinoIcons.slowmo,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  _buildText(word.vietnamese, null),
                  _buildText("Definition", submain),
                  Text(word.definition),
                  _buildText("Example", submain),
                  Text(word.example),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Xem người khác thực hành >",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
