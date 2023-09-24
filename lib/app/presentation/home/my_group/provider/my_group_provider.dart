import 'package:flutter/widgets.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';
import 'package:hurricane_events/data/repository/group_repository/group_repository.dart';

class MyGroupProvider extends ChangeNotifier {
  MyGroupProvider._();
  static final MyGroupProvider instance = MyGroupProvider._();

  AppState _state = AppState.init;
  AppState _groupState = AppState.init;

  final _group = GroupRepository.instance;

  List<GroupDetails?> allGroups = [];
  final List<EventFull?> _allEventsOnGroup = [];

  getUserGroups(String id) async {
    try {
      _state = AppState.loading;
      notifyListeners();

      // BaseNavigator.currentContext.read<UserProvider>().user!.id!
      final res = await _group.getUserGroups(id);
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

  refreshUserGroups(String id) async {
    try {
      final res = await _group.getUserGroups(id);
      if (res.item1 != null) {
        allGroups.clear();
        allGroups = res.item1!;
        notifyListeners();
      }
    } catch (_) {}
  }

  getGroups() async {
    try {
      _state = AppState.loading;
      notifyListeners();

      // BaseNavigator.currentContext.read<UserProvider>().user!.id!
      final res = await _group.getAllGroups();
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

  getGrouEvents(String id) async {
    try {
      _groupState = AppState.loading;
      notifyListeners();

      final res = await _group.getAllGroupEvents(id);
      if (res.item1 != null) {
        _allEventsOnGroup.clear();
        _allEventsOnGroup.addAll(res.item1 ?? []);

        _groupState = AppState.success;
        notifyListeners();
      }

      _groupState = AppState.error;
      notifyListeners();
    } catch (e) {
      _groupState = AppState.error;
      notifyListeners();
    }
  }

  AppState get state => _state;
  AppState get groupEventState => _groupState;

  logOut() {
    _allEventsOnGroup.clear();
    notifyListeners();
  }

  List<EventFull?> get allEvents => _allEventsOnGroup;
}
