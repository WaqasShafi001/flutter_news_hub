import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_hub/features/authentication/data/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthenticationRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationRepository(this._firebaseAuth);

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        return _firebaseAuth.currentUser;
      } else {
        return null;
      }
    } catch (e) {
      log("Error signing in with Google: $e");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
