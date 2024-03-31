import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_news_hub/common/app_keys.dart';
import 'package:flutter_news_hub/common/app_urls.dart';
import 'package:flutter_news_hub/features/news_home/data/repositories/news_repository.dart';
import 'package:flutter_news_hub/features/news_home/domain/model/news.dart';
import 'package:get/get.dart';

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<News?> fetchNews({required int pageSize, required int page}) async {
    try {
      final response = await GetConnect().get(
          '${AppUrls.baseUrl}${AppUrls.pageSize}$pageSize${AppUrls.page}$page${AppUrls.apiKey}');
      return News.fromJson(response.body);
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }

  @override
  Future<void> toggleFavorite(
      {required String userId,
      required String articleId,
      required bool isFavorite}) async {
    final databaseReference =
        FirebaseDatabase.instance.ref(AppKeys.firebaseRefrenceKey);
    try {
      await databaseReference.child(userId).child(articleId).update({
        'favorite': isFavorite,
      });
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }
}
