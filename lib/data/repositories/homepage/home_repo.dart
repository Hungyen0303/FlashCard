import 'package:flashcard_learning/data/services/api/Api1.dart';

class HomeRepo {
  final Api1 api1;

  HomeRepo({required this.api1});

  Future<String> getQuestionFromAI(String topic, String level) async {
    return await api1.getQuestionFromAI(topic, level);
  }

  Future<String> getTopics() async {
    return await api1.getTopics();
  }

  Future<String> generateScoreAndQuestion(
      String humanChat, String current, String nextQuestion) async {
    return await api1.generateScoreAndQuestion(
        humanChat, current, nextQuestion);
  }

  Future<String> generateLastQuestion(String humanChat, String question) async {
    return await api1.generateLastQuestion(humanChat, question);
  }
}
