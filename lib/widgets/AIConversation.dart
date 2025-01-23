import 'package:flashcard_learning/color/AllColor.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Conversations",
                style: style,
              ),
              Text(
                "Có 3 cuộc hội đối thoại ",
                style: style,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [Cardcustom(), Cardcustom(), Cardcustom()],
                ),
              )
            ],
          )),
    );
  }
}
