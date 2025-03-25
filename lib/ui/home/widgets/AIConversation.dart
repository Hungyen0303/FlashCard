import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/utils/enum/level.dart';
import 'package:flashcard_learning/ui/home/widgets/CardCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'conversation_ai_screen.dart';

class AIConversation extends StatefulWidget {
  AIConversation({super.key, required this.conversations});

  List<String> conversations;

  @override
  State<AIConversation> createState() => _AIConversationState();
}

class _AIConversationState extends State<AIConversation> {
  TextStyle style = TextStyle(
    color: MAIN_THEME_PURPLE_TEXT,
  );




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
          height: 300,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: Color(0xFFDEB5D7),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Conversations",
                style: TextStyle(
                  color: Color(0xff6200EE),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Có 3 cuộc hội đối thoại ",
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  color: Color(0xFFF3E5F5),
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CardCustom(
                      title: widget.conversations[0],
                      image: "assets/img-1.jpg",
                      end: 3,
                      start: 2,
                      level: LEVEL.EASY.level,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ConversationAIScreen(
                                  title: widget.conversations[0],
                                  level: LEVEL.EASY.level,
                                )));
                      },
                    ),
                    CardCustom(
                      title: widget.conversations[1],
                      image: "assets/img-2.jpg",
                      end: 5,
                      start: 4,
                      level: LEVEL.MEDIUM.level,
                      onTap: () {},
                    ),
                    CardCustom(
                      title: widget.conversations[2],
                      image: "assets/img-3.jpg",
                      end: 8,
                      start: 7,
                      level: LEVEL.HARD.level,
                      onTap: () {},
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
