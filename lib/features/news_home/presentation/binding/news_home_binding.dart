import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_hub/features/authentication/data/repositories/auth_repository_imp.dart';
import 'package:flutter_news_hub/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_news_hub/features/news_home/data/repositories/news_repository.dart';
import 'package:flutter_news_hub/features/news_home/data/repositories/news_repository_imp.dart';
import 'package:flutter_news_hub/features/news_home/domain/usecases/fetch_news_usecase.dart';
import 'package:flutter_news_hub/features/news_home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:flutter_news_hub/features/news_home/presentation/controller/news_home_controller.dart';
import 'package:get/get.dart';

class NewsHomeBinding implements Bindings {
  @override
  void dependencies() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final authRepository = FirebaseAuthenticationRepository(firebaseAuth);
    final signOutGoogleUseCase = SignOutGoogleUseCase(authRepository);

    final NewsRepository newsRepository = NewsRepositoryImpl();
    final FetchNewsUseCase fetchNewsUseCase = FetchNewsUseCase(newsRepository);

    final ToggleFavoriteUseCase toggleFavoriteUseCase =
        ToggleFavoriteUseCase(newsRepository);

    Get.lazyPut<NewsHomeController>(() => NewsHomeController(
        signOutGoogleUseCase, fetchNewsUseCase, toggleFavoriteUseCase));
  }
}
