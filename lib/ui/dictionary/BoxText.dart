import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Boxtext extends StatelessWidget {
  const Boxtext({super.key, required this.word, required this.onTap});

  final String word;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap() ,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
            color: MAIN_THEME_PINK, borderRadius: BorderRadius.circular(10)),
        child: Text(
          word,
          style: TextStyle(
            color: MAIN_THEME_PINK_TEXT,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
