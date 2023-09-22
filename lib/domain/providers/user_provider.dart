import 'package:flutter/foundation.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/models/user/user_id.dart';
import 'package:hurricane_events/data/repository/user_repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  UserProvider._();
  static final UserProvider instance = UserProvider._();

  final _user = UserRepository.instance;

  AppState _state = AppState.init;

  Future<AppUser?> getUserDetails(String id) async {
    try {
      final result = await _user.getUserDetails(id);

      if (result.item1 != null) {
        return result.item1;
      } else {
        _state = AppState.error;

        notifyListeners();
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<UserId> createUser(
      {required String email,
      required String name,
      required String avatar}) async {
    final result =
        await _user.createUser(email: email, name: name, avatar: avatar);

    return result;
  }

  AppState get state => _state;
}
