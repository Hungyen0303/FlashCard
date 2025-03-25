import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_menu/pie_menu.dart';

class ContentChatContainer extends StatelessWidget {
  const ContentChatContainer(
      {super.key,
      required this.isBot,
      required this.content,
      required this.isLoading});

  final bool isBot;
  final String content;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return PieMenu(
        onPressed: () {},
        child: isBot
            ? Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          "assets/apple-icon.png",
                          width: 45,
                        ),
                      ),
                    ),
                    isLoading || content.isEmpty
                        ? const CircularProgressIndicator()
                        : IntrinsicWidth(
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.1),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(left: 10, top: 20),
                              decoration: BoxDecoration(
                                color: MAIN_THEME_YELLOW,
                                border: Border.all(
                                    width: 1, color: MAIN_THEME_YELLOW_TEXT),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                content,
                              ),
                            ),
                          ),
                  ],
                ),
              )
            : Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                        minWidth: MediaQuery.of(context).size.width * 0.1),
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 10, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      content,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ));
  }
}
