import 'package:flutter/widgets.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';
import 'package:hurricane_events/data/repository/group_repository/group_repository.dart';

class MyGroupProvider extends ChangeNotifier {
  MyGroupProvider._();
  static final MyGroupProvider instance = MyGroupProvider._();

  AppState _state = AppState.init;

  final _group = GroupRepository.instance;

  List<GroupDetails?> allGroups = [];

  refreshGroups() async {
    try {
      _state = AppState.loading;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      final res = await _group.getGroupsList();
      if (res.item1 != null) {
        allGroups = res.item1!;
        _state = AppState.success;
        notifyListeners();
      }

      _state = AppState.error;
      notifyListeners();
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
    }
  }

  AppState get state => _state;
}
