import 'dart:math';
import 'dart:ui';

import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pie_menu/pie_menu.dart';

class Listitem extends StatelessWidget {
  Listitem({super.key, required this.flashCardSet});

  final FlashCardSet flashCardSet;

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

  TextStyle textStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "FontListView ");

  @override
  Widget build(BuildContext context) {
    Map<Color, Color> color = getRandomColor();
    return PieMenu(
        actions: [
          PieAction(
            tooltip: const Text('Play'),
            onSelect: () => print('Play'),

            /// Optical correction
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: FaIcon(FontAwesomeIcons.play),
            ),
          ),
          PieAction(
            tooltip: const Text('Like'),
            onSelect: () => print('Play'),
            child: const FaIcon(
              FontAwesomeIcons.solidThumbsUp,
            ),
          ),
          PieAction(
            tooltip: const Text('Share'),
            onSelect: () => print('Play'),
            child: const FaIcon(FontAwesomeIcons.share),
          ),
        ],
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 2, color: Colors.grey),
            ),
            tileColor: color.values.first,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            leading: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${flashCardSet.numberOfCard}\nPairs",
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            title: Text(
              "${flashCardSet.name}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              "${flashCardSet.minute} minutes",
              style: textStyle,
            ),
            trailing: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.navigate_next),
            ),
          ),
        ));
  }
}
