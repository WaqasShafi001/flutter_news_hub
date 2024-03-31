import 'package:flutter_news_hub/common/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<void> saveUserDetails(
      {required String userId,
      required String userEmail,
      required String username}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppKeys.userIdKey, userId);
    await prefs.setString(AppKeys.userEmailKey, userEmail);
    await prefs.setString(AppKeys.usernameKey, username);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppKeys.userIdKey);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppKeys.userEmailKey);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppKeys.usernameKey);
  }

  static Future<void> clearUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppKeys.userIdKey);
    await prefs.remove(AppKeys.userEmailKey);
    await prefs.remove(AppKeys.usernameKey);
  }
}
