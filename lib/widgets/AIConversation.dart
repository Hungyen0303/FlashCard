import 'package:flashcard_learning/color/AllColor.dart';
import 'package:flashcard_learning/enum/level.dart';
import 'package:flashcard_learning/widgets/CardCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aiconversation extends StatefulWidget {
  const Aiconversation({super.key});

  @override
  State<Aiconversation> createState() => _AiconversationState();
}

class _AiconversationState extends State<Aiconversation> {
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
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          decoration: BoxDecoration(
              color: MAIN_THEME_PURPLE,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Conversations",
                style: TextStyle(
                  color: MAIN_THEME_PURPLE_TEXT,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Có 3 cuộc hội đối thoại ",
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  color: Color(0xFF0a50e7),
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
                    Cardcustom(
                      title: "English at School ",
                      image: "assets/img-1.jpg",
                      end: 5,
                      start: 2,
                      level: LEVEL.EASY.level,
                    ),
                    Cardcustom(
                      title: "Ask professor for final  ",
                      image: "assets/img-2.jpg",
                      end: 5,
                      start: 2,
                      level: LEVEL.MEDIUM.level,
                    ),
                    Cardcustom(
                      title: "Join the show of Taylor ",
                      image: "assets/img-3.jpg",
                      end: 5,
                      start: 2,
                      level: LEVEL.HARD.level,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
