import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:get_storage/get_storage.dart';

class Prefs {
  static final _storage = GetStorage();

  static String? getToken() {
    return _storage.read(StringRes.token);
  }

  static void saveToken(String token) {
    _storage.write(StringRes.token, token);
  }

  static void saveUser(String user) {
    _storage.write(StringRes.currentUserKey, user);
  }

  static String? getCurrentUser() {
    return _storage.read(StringRes.currentUserKey);
  }

  static void destroyOnLogout() {
    _storage.remove(StringRes.currentUserKey);
    _storage.remove(StringRes.token);
  }
}
