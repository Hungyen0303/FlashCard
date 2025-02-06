import 'package:flashcard_learning/widgets/ContentChatContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({super.key});

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Contentchatcontainer(
              isBot: false, content: "alo , can i ask you some question"),
          Contentchatcontainer(isBot: true, content: "Sure , go ahead "),
          Contentchatcontainer(
              isBot: false,
              content: "How to use this word \"ephermeral\" go ahead "),
          Contentchatcontainer(isBot: true, content: "Sure , go ahead "),
          Contentchatcontainer(
              isBot: false,
              content: "How to use this word \"ephermeral\" go ahead "),

          Contentchatcontainer(isBot: true, content: "Sure , go ahead , which word you want to add  "),
          Contentchatcontainer(isBot: false, content: "Sure , go ahead "),

        ],
      ),
    );
  }
}
