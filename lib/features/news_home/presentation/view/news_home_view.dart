import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_news_hub/common/app_colors.dart';
import 'package:flutter_news_hub/common/app_strings.dart';
import 'package:flutter_news_hub/features/news_home/presentation/controller/news_home_controller.dart';
import 'package:flutter_news_hub/features/news_home/presentation/widgets/news_tile.dart';
import 'package:get/get.dart';

class NewsHomePage extends GetView<NewsHomeController> {
  const NewsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                AppColors.deepPurple,
              ),
            ),
            onPressed: () => controller.signOut(),
            icon: const Icon(
              Icons.logout_rounded,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value && controller.newsList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.newsList.length +
                    1, // Add 1 for loading indicator
                itemBuilder: (context, index) {
                  if (index < controller.newsList.length) {
                    final article = controller.newsList[index];
                    log('this is id for each article ${article.source!.id}');
                    return NewsTile(
                      imgUrl: article.urlToImage ?? "",
                      title: article.title ?? "",
                      desc: article.description ?? "",
                      content: article.content ?? "",
                      posturl: article.url ?? "",
                      isFavorite: article.favorite!,
                      callback: () => controller.toggleFavorite(article),
                    );
                  } else {
                    return _buildLoadingIndicator();
                  }
                },
              ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
