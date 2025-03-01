import 'dart:math';
import 'dart:ui';

import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/ui/flashcard_sets/view_models/flashCardSetViewModel.dart';
import 'package:flashcard_learning/utils/LoadingOverlay.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:provider/provider.dart';

import '../../../routing/route.dart';

class FlashCardSetItem extends StatelessWidget {
  FlashCardSetItem({
    super.key,
    required this.flashCardSet,
    required this.edit,
    required this.delete,
    required this.share,
    required this.isGridView,
  });

  final FlashCardSet flashCardSet;
  final Function edit;
  final Function delete;
  final Function share;
  bool isGridView = true;

  void _goToSpecificFlashCardSet(String nameOfSet, BuildContext context) {
    context.push(AppRoute.gotoFlashcardSet(nameOfSet));
  }

  Container _buildGridItem(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: flashCardSet.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "#${flashCardSet.numberOfCard}",
                style: TextStyle(fontSize: 16, color: flashCardSet.color),
              ),
            ),
          ),
          Icon(
            flashCardSet.iconData,
            size: 80,
            color: flashCardSet.color,
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(right: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.timer_outlined, color: flashCardSet.color),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${flashCardSet.minute} minutes",
                      style: TextStyle(color: flashCardSet.color),
                    ),
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    flashCardSet.color,
                    flashCardSet.color.withOpacity(0.5),
                  ]),
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
            child: Text(
              flashCardSet.name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Container _buildListItem() {
    TextStyle textStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "FontListView ");
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 2, color: Colors.grey),
        ),
        tileColor: flashCardSet.color.withOpacity(0.2),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return PieMenu(
        onPressed: () {
          _goToSpecificFlashCardSet(flashCardSet.name, context);
        },
        actions: [
          PieAction(
            tooltip: const Text('Edit'),
            onSelect: () => edit(),

            /// Optical correction
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: FaIcon(FontAwesomeIcons.penToSquare),
            ),
          ),
          PieAction(
            buttonTheme: PieButtonTheme(
                backgroundColor: Colors.red, iconColor: Colors.white),
            tooltip: const Text('Delete'),
            onSelect: () => delete(),
            child: const FaIcon(
              FontAwesomeIcons.trash,
            ),
          ),
          PieAction(
            buttonTheme: PieButtonTheme(
                backgroundColor: Colors.greenAccent, iconColor: Colors.white),
            tooltip: const Text('Share'),
            onSelect: () => share(),
            child: const FaIcon(FontAwesomeIcons.share),
          ),
        ],
        child: isGridView ? _buildGridItem(context) : _buildListItem());
  }
}
