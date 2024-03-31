import 'dart:developer';

import 'package:flutter_news_hub/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_news_hub/features/news_home/presentation/binding/news_home_binding.dart';
import 'package:flutter_news_hub/features/news_home/presentation/view/news_home_view.dart';
import 'package:flutter_news_hub/utils/user_preferences.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  SignInController(this._signInWithGoogleUseCase);

  var isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    final user = await _signInWithGoogleUseCase.call();
    if (user != null) {
      log('this is user name ${user.displayName}, and user email ${user.email}');
      SharedPreferencesUtil.saveUserDetails(
          userId: user.uid,
          userEmail: user.email!,
          username: user.displayName!);

      isLoading.value = false;
      Get.offAll(() => const NewsHomePage(), binding: NewsHomeBinding());
    } else {
      log('Did not sign-in with google');
      isLoading.value = false;
    }
  }
}
