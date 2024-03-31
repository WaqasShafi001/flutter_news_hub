import 'dart:developer';

import 'package:flutter_news_hub/features/authentication/data/repositories/auth_repository.dart';

class SignOutGoogleUseCase {
  final AuthRepository _authRepository;

  SignOutGoogleUseCase(this._authRepository);

  Future<bool> call() async {
    try {
      await _authRepository.signOut();
      return true;
    } catch (e) {
      log("Error signing out in with Google: $e");
      return false;
    }
  }
}
