import 'package:flashcard_learning/data/services/api/api.dart';
import 'package:flashcard_learning/domain/models/user.dart';

class HomeRepo {
  final Api api;

  HomeRepo({required this.api});

  Future<String> getQuestionFromAI(String topic, String level) async {
    return await api.getQuestionFromAI(topic, level);
  }

  Future<String> getTopics() async {
    return await api.getTopics();
  }

  Future<String> generateScoreAndQuestion(
      String humanChat, String current, String nextQuestion) async {
    return await api.generateScoreAndQuestion(humanChat, current, nextQuestion);
  }

  Future<String> generateLastQuestion(String humanChat, String question) async {
    return await api.generateLastQuestion(humanChat, question);
  }
}
