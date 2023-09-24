import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/home/home.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/repository/auth_repository/auth_repository.dart';
import 'package:hurricane_events/data/repository/user_repository/user_repository.dart';
import 'package:hurricane_events/data/services/local_storage/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._();
  static final AuthProvider instance = AuthProvider._();

  final _auth = AuthRepository.instance;
  final _userRepo = UserRepository.instance;
  final _localStorage = AppStorage.instance;

  AppState _state = AppState.init;

  googleLogin() async {
    try {
      _state = AppState.loading;
      notifyListeners();

      await _auth.logOut();

      final result = await _auth.googleAuth();
      if (result.item1 != null) {
        final data = result.item1;
        print(data);
        assert(data!.email != null);
        assert(data!.displayName != null);

        final s = await _userRepo.createUser(
          email: data!.email!,
          name: data.displayName!,
          avatar: data.photoURL!,
          token: data.refreshToken ?? result.item3 ?? "",
        );

        if (s.item1 != null) {
          if (s.item1?.userId != null) {
            _localStorage.saveUser(
              AppUser(
                avatar: data.photoURL!,
                email: data.email!,
                id: s.item1!.userId!,
                name: data.displayName!,
              ).toJson(),
            );
            _localStorage.saveId(s.item1!.userId!);
            _localStorage.saveJwtToken(s.item1!.authorizationToken!);
            _state = AppState.success;
            notifyListeners();
            return BaseNavigator.pushNamed(HomeScreen.routeName);
          }

          _state = AppState.error;
          notifyListeners();
        } else {
          _state = AppState.error;
          notifyListeners();
        }
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
