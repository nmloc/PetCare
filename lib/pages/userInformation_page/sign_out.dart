import 'package:amity_sdk/amity_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseSharedPreferences {
  BaseSharedPreferences._();

  static Future<void> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

Future<bool> logout() async {
  await BaseSharedPreferences.remove('loggedUser');
  return true;
}
