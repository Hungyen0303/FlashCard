import 'dart:math';
import 'dart:ui';

import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

import '../../../routing/route.dart';

class Griditem extends StatelessWidget {
  Griditem({
    super.key,
    required this.flashCardSet,
  });

  final FlashCardSet flashCardSet;

  Future<void> _showContextMenu(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx, // Vị trí x của lần nhấn
        position.dy, // Vị trí y của lần nhấn
        position.dx,
        position.dy,
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    // Xử lý khi chọn
    if (result != null) {
      switch (result) {
        case 'edit':
          _editFlashCardSet(context);
          break;
        case 'delete':
          _deleteFlashCardSet(context);
          break;
      }
    }
  }

  void _editFlashCardSet(BuildContext context) {
    // Logic chỉnh sửa
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing ')),
    );
  }

  void _deleteFlashCardSet(BuildContext context) {
    // Logic xóa
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted ')),
    );
  }

  void _goToSpecificFlashCardSet(String nameOfSet, BuildContext context) {
    context.push(AppRoute.gotoFlashcardSet("math"));
  }

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
    void showPopUpMenu() {}
    Map<Color, Color> color = getRandomColor();
    return GestureDetector(
      onLongPress: () => {_showContextMenu(context, const Offset(0, 0))},
      onTap: () => _goToSpecificFlashCardSet(flashCardSet.name, context),
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
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "#${flashCardSet.numberOfCard}",
                  style: TextStyle(fontSize: 16, color: color.keys.first),
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
                      Icon(Icons.timer_outlined, color: color.keys.first),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${flashCardSet.minute} minutes",
                        style: TextStyle(color: color.keys.first),
                      ),
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
              child: Text(
                flashCardSet.name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
