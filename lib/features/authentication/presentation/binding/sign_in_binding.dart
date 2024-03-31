import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_hub/features/authentication/data/repositories/auth_repository_imp.dart';
import 'package:flutter_news_hub/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_news_hub/features/authentication/presentation/controller/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final authRepository = FirebaseAuthenticationRepository(firebaseAuth);
    final signInWithGoogleUseCase = SignInWithGoogleUseCase(authRepository);
    Get.lazyPut<SignInController>(
        () => SignInController(signInWithGoogleUseCase));
  }
}
