import 'package:flutter/material.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/repository/auth_repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._();
  static final AuthProvider instance = AuthProvider._();

  final _auth = AuthRepository.instance;

  AppState _state = AppState.init;

  googleLogin() async {
    try {
      _state = AppState.loading;
      notifyListeners();

      await _auth.logOut();

      final result = await _auth.googleAuth();
      if (result.item1 != null) {
        print(result.item1);

        _state = AppState.success;
        notifyListeners();
      } else {
        _state = AppState.error;
        notifyListeners();
      }
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
    }
  }

  AppState get state => _state;
}
