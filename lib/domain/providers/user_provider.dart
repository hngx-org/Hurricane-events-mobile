import 'package:flutter/foundation.dart';
import 'package:hurricane_events/app/presentation/home/my_group/provider/my_group_provider.dart';
import 'package:hurricane_events/app/presentation/sign_up/screens/sign_up.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/repository/auth_repository/auth_repository.dart';
import 'package:hurricane_events/data/repository/user_repository/user_repository.dart';
import 'package:hurricane_events/data/services/local_storage/local_storage.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:hurricane_events/domain/providers/global_provider.dart';

class UserProvider extends ChangeNotifier {
  UserProvider._();
  static final UserProvider instance = UserProvider._();
  final _user = UserRepository.instance;
  final _local = AppStorage.instance;
  final _auth = AuthRepository.instance;

  final _event = EventProvider.instance;
  final _group = MyGroupProvider.instance;
  final _global = GlobalProvider.instance;

  AppState _state = AppState.init;

  AppUser? _appUser;

  getUserDetails() async {
    try {
      final localData = _local.getUserData();
      if (localData != null) {
        _appUser = localData;
        notifyListeners();
      }

      if (_local.getId() != null) {
        final result = await _user.getUserDetails(_local.getId()!);
        if (result.item1 != null) {
          _appUser = result.item1;
          notifyListeners();
        }
      } else {
        logOut();
      }
    } catch (_) {}
  }

  logOut() async {
    try {
      _state = AppState.loading;
      notifyListeners();

      final s = await _auth.logOut();
      if (s.item1 == null && s.item2 == null) {
        _local
          ..clearUser()
          ..clearId();
        _global.logOut();
        _event.logOut();
        _group.logOut();
        _state = AppState.success;
        notifyListeners();

        BaseNavigator.pushNamedAndclear(
          SignUpScreen.routeName,
        );
      } else {
        _state = AppState.error;
        notifyListeners();
      }
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
    }
  }

  AppUser? get user => _appUser;
  AppState get state => _state;
}
