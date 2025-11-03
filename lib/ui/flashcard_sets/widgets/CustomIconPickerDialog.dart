import 'package:flashcard_learning/core/constants/app_icons.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import 'CustomCardProvider.dart';

class CustomIconPickerDialog extends StatefulWidget {
  const CustomIconPickerDialog({super.key});

  @override
  State<CustomIconPickerDialog> createState() => _CustomIconPickerDialogState();
}

class _CustomIconPickerDialogState extends State<CustomIconPickerDialog> {
  Color iconColor = MAIN_THEME_BLUE_TEXT;

  Widget _buildGridIcon() {
    return Container(
      padding: EdgeInsets.zero,
      height: 100,
      child: GridView.count(
        crossAxisCount: 4,
        padding: EdgeInsets.zero,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        children: IconMapper.educationIcons
            .map((e) => IconButton(
                  onPressed: () {
                    Provider.of<CustomCardProvider>(context, listen: false)
                        .setIconData(e);

                    context.pop();
                  },
                  icon: Icon(
                    size: 30,
                    e,
                    color: MAIN_THEME_BLUE_TEXT,
                  ),
                ))
            .toList(),
      ),
    );
  }

  void _showIconPickerDialog() async {
    QuickAlert.show(
      context: context,
      cancelBtnText: "Discard",
      title: "-- Choose an icon -- ",
      titleColor: Colors.deepPurple,
      showCancelBtn: true,
      cancelBtnTextStyle:
          const TextStyle(color: Colors.redAccent, fontSize: 20),
      type: QuickAlertType.custom,
      barrierDismissible: true,
      customAsset: 'assets/icon-picker.jpg',
      widget: _buildGridIcon(),
      onCancelBtnTap: () {
        context.pop();
      },
      onConfirmBtnTap: () async {
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Consumer<CustomCardProvider>(
          builder: (context, customCardProvider, child) {
        return customCardProvider.iconData == null
            ? ElevatedButton(
                onPressed: () {
                  _showIconPickerDialog();
                },
                child: const Text(
                  "Choose an icon ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: MAIN_THEME_BLUE_TEXT),
                ))
            : IconButton(
                onPressed: () {
                  _showIconPickerDialog();
                },
                icon: IconTheme(
                    data: IconThemeData(
                        size: 40, color: customCardProvider.iconColor),
                    child: Icon(customCardProvider.iconData ?? Icons.book)));
      }),
    );
  }
}
