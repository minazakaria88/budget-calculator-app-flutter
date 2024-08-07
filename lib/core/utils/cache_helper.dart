import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

 static void setString({
    required String key,
    required String value,
  }) {
    sharedPreferences!.setString(key, value);
  }

  static String? getString({
    required String key,
  }) {
    return sharedPreferences!.getString(key);
  }

  static void setBool({
    required String key,
    required bool value,
  }) {
    sharedPreferences!.setBool(key, value);
  }

  static  bool? getBool({
    required String key,
  }) {
   return sharedPreferences!.getBool(key);
  }
}

class CacheHelperKeys
{
  static const String isWelcome='isWelcome';
  static const String balance='balance';
  static const String currency='currency';
}
