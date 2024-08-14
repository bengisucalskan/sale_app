import 'package:flutter_dotenv/flutter_dotenv.dart';

extension DotEnvEx on String {
  String get toEnv => dotenv.env[this] ?? '';
}
