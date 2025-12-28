import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pie_menu/pie_menu.dart';

class ContentChatContainer extends StatelessWidget {
  const ContentChatContainer(
      {super.key,
      required this.controller,
      required this.isBot,
      required this.content,
      required this.isLoading});

  final bool isBot;
  final String content;
  final bool isLoading;
  final ScrollController controller;
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  Widget aiResponseWidget(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  fit: BoxFit.contain,
                  "assets/gemini.png",
                  width: 30,
                ),
              ),
            ),
          ),
          isLoading || content.isEmpty
              ? const CircularProgressIndicator()
              : ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                      minWidth: MediaQuery.of(context).size.width * 0.1),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xffcadcef),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text("Gemini flash 2.0",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Color.fromARGB(221, 10, 21, 74))),
                            ),
                            GestureDetector(
                              onTap: () => copyText(content),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.copy,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Markdown(
                          controller: controller,
                          data: content,
                          shrinkWrap: true,
                          selectable: true,
                          padding: EdgeInsets.zero,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            listBullet: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget humanResponseWidget(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              minWidth: MediaQuery.of(context).size.width * 0.1),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 10, top: 20),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PieMenu(
        onPressed: () {},
        actions: [
          PieAction(
            tooltip: const Text("Copy"),
            onSelect: () => copyText(content),
            child: const Icon(
              CupertinoIcons.doc_on_doc,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
        child:
            isBot ? aiResponseWidget(context) : humanResponseWidget(context));
  }
}
