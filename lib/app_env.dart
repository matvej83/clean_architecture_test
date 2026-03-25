import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static String get mode => dotenv.env['APP_MODE']!;

  static String get baseUrl => dotenv.env['BASE_URL']!;
}
