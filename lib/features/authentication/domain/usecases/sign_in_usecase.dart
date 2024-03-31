import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_hub/features/authentication/data/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  Future<User?> call() async {
    try {
      final user = await _authRepository.signInWithGoogle();
      return user;
    } catch (e) {
      log("Error signing in with Google: $e");
      return null;
    }
  }
}
