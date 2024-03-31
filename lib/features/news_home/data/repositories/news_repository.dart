import 'package:flutter_news_hub/features/news_home/domain/model/news.dart';

abstract class NewsRepository {
  Future<News?> fetchNews({required int pageSize, required int page});
  Future<void> toggleFavorite(
      {required String userId,
      required String articleId,
      required bool isFavorite});
}
