import 'package:flutter_news_hub/features/news_home/data/repositories/news_repository.dart';

class ToggleFavoriteUseCase {
  final NewsRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<void> call(
      {required String userId,
      required String articleId,
      required bool isFavorite}) async {
    try {
      return await _repository.toggleFavorite(
          userId: userId, articleId: articleId, isFavorite: isFavorite);
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }
}
