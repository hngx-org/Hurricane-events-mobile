import 'package:flutter/foundation.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/repository/group_repository/group_repository.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';

class AddGroupProvider extends ChangeNotifier {
  AddGroupProvider._();
  static final AddGroupProvider instance = AddGroupProvider._();

  final _user = UserProvider.instance;

  final _group = GroupRepository.instance;
  AppState _state = AppState.init;

  createGroup({
    required String groupTitle,
    required List<String> listOfFriends,
  }) async {
    try {
      _state = AppState.loading;
      notifyListeners();
      final res = await _group.createGroup(
        title: groupTitle,
        id: _user.user!.id!,
      );

      if (res.item1 != null) {
        if (listOfFriends.isNotEmpty) {
          final r = await _group.inviteUsersToGroup(
            _user.user!.id!,
            res.item1!.id!,
            listOfFriends,
          );

          if (r.item1 != null) {
            if (r.item1!.addedUsers!.isNotEmpty) {
              _state = AppState.success;
              notifyListeners();
              await Future.delayed(const Duration(milliseconds: 200));
              BaseNavigator.pop();
            }
          }
        } else {
          _state = AppState.success;
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 200));
          BaseNavigator.pop();
        }
      }

      _state = AppState.error;
      notifyListeners();
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
    }
  }

  addUser({String? groupId}) async {
    try {
      _state = AppState.loading;
      notifyListeners();
      await _user.getUserDetails();
      final res = await _group.addUser(
        groupId: groupId ?? "0ed65396-a368-4f1c-a316-bfb0769ea819",
        userId: _user.user?.id ?? "805082bb-0e66-4a08-82cd-f26664bd56e1",
      );

      if (res.item1 != null) {
        _state = AppState.success;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 1000));
        BaseNavigator.pop();
      }
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
    }
  }

  AppState get state => _state;
}
