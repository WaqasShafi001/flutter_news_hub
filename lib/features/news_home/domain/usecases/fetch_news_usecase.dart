import 'package:flutter_news_hub/features/news_home/data/repositories/news_repository.dart';
import 'package:flutter_news_hub/features/news_home/domain/model/news.dart';

class FetchNewsUseCase {
  final NewsRepository _repository;

  FetchNewsUseCase(this._repository);

  Future<News?> call({required int pageSize, required int page}) async {
    try {
      return await _repository.fetchNews(pageSize: pageSize, page: page);
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}
