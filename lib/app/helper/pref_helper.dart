// ignore_for_file: avoid_positional_boolean_parameters

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// MAKE KEY KEEP PRIVATE ————————————————————————————————————————————————————————
const _PREF_IS_LOGIN = '_PREF_IS_LOGIN';
const _PREF_TOKEN = '_PREF_TOKEN';
// —————————————————————————————————————————————————————————————————————————————

mixin PrefHelper {
  static final _pref = Get.find<GetStorage>();

  // reset / remove preference
  static void resetData() => _pref.erase();

  static void deleteData(String prefKey) => _pref.remove(prefKey);

  // is_login
  static bool? get isLogin => _pref.read(_PREF_IS_LOGIN);

  static void setIsLogin(bool value) => _pref.write(_PREF_IS_LOGIN, value);

  // user_token
  static String? get userToken => _pref.read(_PREF_TOKEN);

  static Future<void> setUserToken(String value) async => _pref.write(_PREF_TOKEN, value);
}
