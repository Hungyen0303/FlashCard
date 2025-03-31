import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flashcard_learning/utils/enum/level.dart';
import 'package:flashcard_learning/ui/home/widgets/CardCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // Add this import for shimmer effect

import '../view_models/MainScreenViewModel.dart';
import 'conversation_ai_screen.dart';

class AIConversation extends StatefulWidget {
  AIConversation({super.key});

  @override
  State<AIConversation> createState() => _AIConversationState();
}

class _AIConversationState extends State<AIConversation> {
  TextStyle style = TextStyle(
    color: MAIN_THEME_PURPLE_TEXT,
  );

  late List<String> conversations;
  late Future loadData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData = context.read<MainScreenViewModel>().getListConversation().then((value) {
      setState(() {
        conversations = context.read<MainScreenViewModel>().conversation;
        isLoading = false;
      });
    });
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 150,
        height: 210,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        height: 300,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: MAIN_BOX_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "🚀 AI Conversations",
              style: TextStyle(
                color: Color(0xff187ee1),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Có 3 cuộc hội đối thoại",
              style: TextStyle(
                fontFamily: "MyCustomFont",
                color: Color(0xFF0C2849),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: isLoading
                    ? List.generate(3, (index) => _buildShimmerCard())
                    : [
                  CardCustom(
                    title: conversations[0],
                    image: "assets/img-1.jpg",
                    end: 3,
                    start: 2,
                    level: LEVEL.EASY.level,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConversationAIScreen(
                            title: conversations[0],
                            level: LEVEL.EASY.level,
                          )));
                    },
                  ),
                  CardCustom(
                    title: conversations[1],
                    image: "assets/img-2.jpg",
                    end: 5,
                    start: 4,
                    level: LEVEL.MEDIUM.level,
                    onTap: () {},
                  ),
                  CardCustom(
                    title: conversations[2],
                    image: "assets/img-3.jpg",
                    end: 8,
                    start: 7,
                    level: LEVEL.HARD.level,
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}