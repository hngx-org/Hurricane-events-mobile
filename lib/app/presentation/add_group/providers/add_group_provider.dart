import 'package:flutter/foundation.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/repository/group_repository/group_repository.dart';

class AddGroupProvider extends ChangeNotifier {
  AddGroupProvider._();
  static final AddGroupProvider instance = AddGroupProvider._();

  final _group = GroupRepository.instance;
  AppState _state = AppState.init;

  createGroup({required String groupTitle}) async {
    try {
      _state = AppState.loading;
      notifyListeners();
      final res = await _group.createGroup(title: groupTitle);

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
