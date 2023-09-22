import 'dart:convert';

import 'package:hurricane_events/data/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppKeys {
  static const String profile = "profile";
  static const String token = "token";
}

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

  void clearUser() async {
    await _sharedPreferences.remove(AppKeys.profile);
  }

  void clearId() async {
    await _sharedPreferences.remove(AppKeys.token);
  }

  saveId(String token) async {
    await _sharedPreferences.setString(AppKeys.token, token);
  }

  String? getId() {
    return _sharedPreferences.getString(AppKeys.token);
  }

  saveUser(Map<String, dynamic> data) async {
    await _sharedPreferences.setString(
      AppKeys.profile,
      json.encode(data),
    );
  }

  AppUser? getUserData() {
    final q = _sharedPreferences.getString(AppKeys.profile);
    if (q == null) {
      return null;
    }
    AppUser userData = AppUser.fromJson(
      json.decode(_sharedPreferences.getString(AppKeys.profile) ?? ""),
    );
    return userData;
  }

  bool get userHasId => _sharedPreferences.getString(AppKeys.token) != null;

  ///This is an example of how to get values from this initializer after storage using getters
  // bool get userHasPin => _sharedPreferences.getString("token") != null;
}
