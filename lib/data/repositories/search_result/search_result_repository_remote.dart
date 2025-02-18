import 'package:flashcard_learning/data/repositories/search_result/search_result_repository.dart';
import 'package:flashcard_learning/data/services/api/ApiClient.dart';

class SearchResultRepositoryRemote implements SearchResultRepository {
  SearchResultRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  void search(String word) {}
}
