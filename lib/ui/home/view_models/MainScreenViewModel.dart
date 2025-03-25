import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../data/repositories/chatWithAI/Prompt.dart';

class MainScreenViewModel extends ChangeNotifier {
  String API_KEY = "AIzaSyBax0qdrfE8U0TzsW4OISS4VZ3DqLic20s";
  List<String> conversation = [];

  bool hasError = false;

  String messageErrors = "";

  Future<void> getListConversation() async {
    if (conversation.isNotEmpty) return;
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: API_KEY,
    );

    var content = [Content.text(Prompt.promptForGettingTopic)];
    var response = await model.generateContent(content);
    String topicText = response.text ?? "";
    if (topicText.isEmpty) return;

    content = [Content.text(Prompt.promptForGettingTitleFromTopic(topicText))];
    response = await model.generateContent(content);

    String titleText = response.text ?? "";
    if (titleText.isEmpty) return;

    titleText.split(",").forEach((e) {
      conversation.add(e.trim());
    });
  }
}
