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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "#${flashCardSet.numOfCard}",
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
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      flashCardSet.color,
                      flashCardSet.color.withOpacity(0.5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey,
                      offset: Offset(1, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  flashCardSet.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Đặt icon hoàn thành ở góc trên bên phải
          if (flashCardSet.done)
            Positioned(
              top: 8,
              right: 8,
              child: _buildIconComplete(),
            ),
        ],
      ),
    );
  }

  Widget _buildIconComplete() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: flashCardSet.done
          ? Container(
        key: ValueKey("complete"),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 24,
        ),
      )
          : SizedBox.shrink(key: ValueKey("empty")),
    );
  }

  Container _buildListItem() {
    TextStyle textStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: "FontListView",
      color: flashCardSet.color,
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 2, color: flashCardSet.color),
        ),
        tileColor: flashCardSet.color.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${flashCardSet.numOfCard}\nPairs",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                flashCardSet.name,
                style: TextStyle(
                  fontSize: 20,
                  color: flashCardSet.color,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildIconComplete(), // Đặt icon hoàn thành bên phải tên
          ],
        ),
        trailing: Container(
          margin: const EdgeInsets.only(right: 10),
          child: Icon(
            flashCardSet.iconData,
            size: 50,
            color: flashCardSet.color,
          ),
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
