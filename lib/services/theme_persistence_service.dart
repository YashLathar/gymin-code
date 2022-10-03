import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseThemeService {
  Future<void> setTheme(bool value);
  Future<bool> getTheme();
}

final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService();
});

class ThemeService implements BaseThemeService {
  static const PREF_KEY = "themeOnDisk";

  @override
  Future<void> setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  @override
  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}

abstract class BaseLocalDBService {
  Future<String> getUserName();
  Future<void> setUserName(String username);
}

class LocalDBService implements BaseLocalDBService {
  static const PREF_KEY = "themeOnDisk";

  @override
  Future<String> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PREF_KEY) ?? "Unknown";
  }

  @override
  Future<void> setUserName(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(PREF_KEY, username);
  }
}
