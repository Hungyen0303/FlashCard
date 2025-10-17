import 'package:flashcard_learning/data/repositories/search_result/search_result_repository.dart';
import 'package:flashcard_learning/data/services/api/Api1.dart';

class SearchResultRepositoryRemote implements SearchResultRepository {
  SearchResultRepositoryRemote({
    required Api apiClient,
  }) : _apiClient = apiClient;

  final Api _apiClient;

  @override
  void search(String word) {}
}
