import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._privateConstructor();

  static final LocalStorage localStorage = LocalStorage._privateConstructor();
  static const String KEY_IS_SIGNED_IN = "is_signed_in";

  Future<bool> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveBool(String username, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(username, value);
  }
}