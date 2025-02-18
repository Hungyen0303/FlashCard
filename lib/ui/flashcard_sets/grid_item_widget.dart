import 'dart:math';
import 'dart:ui';

import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Griditem extends StatelessWidget {
  Griditem(
      {super.key,
      required this.name,
      required this.numberOfCard,
      required this.minute,
      required this.onTap});

  final String name;

  final int numberOfCard;
  final int minute;
  final Function onTap;

  Map<Color, Color> getRandomColor() {
    Random randomInt = Random();
    List<Map<Color, Color>> colors = [
      {MAIN_THEME_PURPLE_TEXT: MAIN_THEME_PURPLE},
      {MAIN_THEME_BLUE_TEXT: MAIN_THEME_BLUE},
      {MAIN_THEME_YELLOW_TEXT: MAIN_THEME_YELLOW},
      {MAIN_THEME_PINK_TEXT: MAIN_THEME_PINK}
    ];
    return colors[randomInt.nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    Map<Color, Color> color = getRandomColor();
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        foregroundDecoration: BoxDecoration(),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: color.values.first,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "#$numberOfCard",
                  style: TextStyle(fontSize: 16,
                  color: color.keys.first),
                ),
              ),
              flex: 5,
            ),
            Icon(
              LineIcons.bookOpen,
              size: 80,
              color: color.keys.first,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(right: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.timer_outlined , color: color.keys.first),
                      SizedBox(
                        width: 5,
                      ),
                      Text("$minute minutes" , style: TextStyle(
                          color: color.keys.first
                      ),),
                    ],
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    offset: Offset(1, 1),
                  )
                ],
                color: Colors.grey[400],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              alignment: Alignment.center,
              child: Text(name , style:
                TextStyle(
                  fontSize:14 ,
                  fontWeight: FontWeight.w600
                ),),
            )
          ],
        ),
      ),
    );
  }
}
