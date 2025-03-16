import 'package:flashcard_learning/data/repositories/search_result/search_result_repository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';

class SearchResultRepositoryRemote implements SearchResultRepository {
  SearchResultRepositoryRemote({
    required Api1 apiClient,
  }) : _apiClient = apiClient;

  final Api1 _apiClient;

  @override
  void search(String word) {}
}
