import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<void> setTheme(String mode);

  String? getTheme();
}

@LazySingleton(as: ThemeLocalDataSource)
class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  ThemeLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static const _key = 'theme_mode';

  @override
  Future<void> setTheme(String value) async {
    await sharedPreferences.setString(_key, value);
  }

  @override
  String? getTheme() {
    return sharedPreferences.getString(_key);
  }
}
