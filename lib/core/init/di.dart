import 'package:sale_app/core/init/cache/locale_manager.dart';
import 'package:sale_app/core/mixin/env_mixin.dart';

class Di {
  static Future<void> init() async {
    await EnvManager.loadDotEnv();
    await LocaleManager.preferencesInit();
  }
}
