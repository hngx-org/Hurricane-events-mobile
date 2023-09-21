import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static final AppStorage instance = AppStorage._instance();
  late SharedPreferences _sharedPreferences;
  AppStorage._instance();

  Future initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance().then((value) async {
      return value;
    });
  }

  void clearCache() async {
    await _sharedPreferences.clear();
  }

  ///This is an example of how to get values from this initializer after storage using getters
  // bool get userHasPin => _sharedPreferences.getString("token") != null;
}
