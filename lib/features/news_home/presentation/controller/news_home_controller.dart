import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_hub/common/app_keys.dart';
import 'package:flutter_news_hub/common/app_strings.dart';
import 'package:flutter_news_hub/common/app_urls.dart';
import 'package:flutter_news_hub/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_news_hub/features/authentication/presentation/binding/sign_in_binding.dart';
import 'package:flutter_news_hub/features/authentication/presentation/view/sign_in_view.dart';
import 'package:flutter_news_hub/features/news_home/domain/model/news.dart';
import 'package:flutter_news_hub/features/news_home/domain/usecases/fetch_news_usecase.dart';
import 'package:flutter_news_hub/features/news_home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:flutter_news_hub/utils/user_preferences.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NewsHomeController extends GetxController {
  final SignOutGoogleUseCase _signOutUseCase;
  final FetchNewsUseCase _fetchNewsUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  NewsHomeController(this._signOutUseCase, this._fetchNewsUseCase,
      this._toggleFavoriteUseCase);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  var isLoading = false.obs;

  final newsList = <Articles>[].obs;

  var currentPageSize = 10.obs;
  var currentPage = 1.obs;
  var totalResults = 0.obs;

  var isFavorite = false.obs;

  final ScrollController scrollController = ScrollController();

  Future<void> signOut() async {
    isLoading.value = true;

    var result = await _signOutUseCase.call();
    if (result) {
      Get.offAll(() => const SignInPage(), binding: SignInBinding());
      isLoading.value = false;
    } else {
      log('Did not sign-out with google');
      isLoading.value = false;
    }
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      final News? fetchedNews = await _fetchNewsUseCase(
          pageSize: currentPageSize.value, page: currentPage.value);
      if (fetchedNews != null) {
        totalResults.value = fetchedNews.totalResults ?? 0;
        fetchedNews.articles?.forEach((article) {
          article.source!.id = const Uuid().v4();
          article.favorite = isFavorite.value;
        });

        newsList.addAll(fetchedNews.articles ?? []);

        log('this is total news for first load = ${newsList.length}');
      }
      isLoading.value = false;
    } catch (e) {
      log('Error fetching news: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreNews() {
    if (newsList.length < totalResults.value) {
      currentPage.value++;
      fetchNews();
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreNews();
    }
  }

  Future<void> toggleFavorite(Articles article) async {
    String? userId = await SharedPreferencesUtil.getUserId();

    // isFavorite.value = !isFavorite.value;
    try {
      if (userId != null && isFavorite.value == true) {
        await _toggleFavoriteUseCase.call(
            userId: userId,
            articleId: article.source!.id!,
            isFavorite: article.favorite!);
        newsList.refresh();
      } else {
        await _toggleFavoriteUseCase.call(
            userId: userId!,
            articleId: article.source!.id!,
            isFavorite: !article.favorite!);
        newsList.refresh();
      }
    } catch (e) {
      log('Error toggling favorite: $e');
    }

    final databaseReference =
        FirebaseDatabase.instance.ref(AppKeys.firebaseRefrenceKey);
    final userArticleRef =
        databaseReference.child(userId!).child(article.source!.id!);
    userArticleRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      article.favorite = snapshot.child('favorite').value as bool;
    });
  }

  void sendFCMNotification() {
    // Replace with your FCM server key
    const String serverKey = AppUrls.fcmServerKey;

    // Replace with your device token or topic

    const String deviceToken = AppStrings.appName;

    // Define the notification message
    final message = {
      'notification': {
        'title': 'New Favorite Added',
        'body': 'You have favorited something!',
      },
      'to': deviceToken, // or 'topic': 'YOUR_TOPIC'
    };

    // Send the FCM notification
    _firebaseMessaging.subscribeToTopic(deviceToken);
  }
}
