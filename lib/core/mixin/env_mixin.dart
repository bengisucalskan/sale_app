import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sale_app/core/consts/app_consts.dart';

mixin EnvManager {
  static Future<void> loadDotEnv() async {
    await dotenv.load(fileName: AppConsts.ENV_ASSET_PATH);
  }
}
