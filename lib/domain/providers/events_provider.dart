import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/models/comments/comment.dart';
import 'package:hurricane_events/data/models/comments/create_comments.dart';
import 'package:hurricane_events/data/models/events/add_events_modal.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/repository/comment_repositpory/comments_repository.dart';
import 'package:hurricane_events/data/repository/event_repository/event_repository.dart';
import 'package:hurricane_events/data/repository/group_repository/group_repository.dart';
import 'package:hurricane_events/domain/providers/global_provider.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';

import '../../data/models/groups/group_details.dart';

class EventProvider extends ChangeNotifier {
  EventProvider._();
  static final EventProvider instance = EventProvider._();

  final _event = EventRepository.instance;
  final _comm = CommentsRepository.instance;
  final _group = GroupRepository.instance;
  final _user = UserProvider.instance;

  AppState _state = AppState.init;
  AppState _timelineState = AppState.init;
  AppState _eventState = AppState.init;
  AppState _getGroupState = AppState.init;
  AppState _timelineFriendsState = AppState.init;

  EventFull? _ev;

  List<GroupDetails?> _allGroups = [];

  final List<EventNorm> _events = [];
  final List<EventFull> _userAndFriendevents = [];

  final List<Comment> _comments = [];

  bool expressedInterest = false;

  final Map<DateTime, List<EventNorm>> _eventsCalendar = {};
  final Map<DateTime, List<EventFull>> _userEventsCalendar = {};

  getGroups() async {
    try {
      _getGroupState = AppState.loading;
      notifyListeners();

      final res = await _group.getAllGroups();
      if (res.item1 != null) {
        _allGroups.clear();
        _allGroups = res.item1!;
        _getGroupState = AppState.success;
        notifyListeners();
      }

      _getGroupState = AppState.error;
      notifyListeners();
    } catch (e) {
      _getGroupState = AppState.error;
      notifyListeners();
    }
  }

  createEvent({
    required AddEventsRequest body,
    required GroupDetails group,
  }) async {
    try {
      _state = AppState.loading;
      notifyListeners();

      final s = await _event.createEvent(body: body);
      if (s.item1 != null) {
        if (s.item1 == true) {
          await Future.delayed(const Duration(milliseconds: 200));
          _state = AppState.success;
          notifyListeners();
          BaseNavigator.pop([
            body.title,
            body.location,
            group.id,
          ]);
        }
      }

      _state = AppState.error;
      notifyListeners();
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
    }
  }

  Future<bool> deleteEvent({required String eventId}) async {
    try {
      final s = await _event.deleteEvent(eventId);
      if (s.item1 != null) {
        if (s.item1 == true) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  getEventId({required String id}) async {
    try {
      _eventState = AppState.loading;
      notifyListeners();

      final s = await _event.getEventDetail(id);
      if (s.item1 != null) {
        await Future.delayed(const Duration(milliseconds: 200));
        _ev = s.item1;
        _eventState = AppState.success;
        notifyListeners();
      }

      _eventState = AppState.error;
      notifyListeners();
    } catch (e) {
      _eventState = AppState.error;
      notifyListeners();
    }
  }

  refreshEvents({
    String? eventTitle,
    String? location,
    String? groupId,
  }) async {
    try {
      final s = await _event.getEvents();
      if (s.item1 != null) {
        _events.clear();
        _events.addAll(s.item1 ?? []);
        _eventsCalendar.clear();
        for (var i = 0; i < s.item1!.length; i++) {
          final data = s.item1![i];
          _eventsCalendar.addAll({
            DateTime.parse("${data.startDate!.toIso8601String()}Z"): [data]
          });
        }
        notifyListeners();
        if (location != null && eventTitle != null) {}
      }
    } catch (_) {}
  }

  getEvents() async {
    try {
      _timelineState = AppState.loading;
      notifyListeners();

      final s = await _event.getEvents();
      if (s.item1 != null) {
        _events.clear();
        _events.addAll(s.item1 ?? []);
        for (var i = 0; i < s.item1!.length; i++) {
          final data = s.item1![i];
          _eventsCalendar.addAll({
            DateTime.parse("${data.startDate!.toIso8601String()}Z"): [data]
          });
        }

        _timelineState = AppState.success;
        notifyListeners();
      }

      _timelineState = AppState.error;
      notifyListeners();
    } catch (e) {
      _timelineState = AppState.error;
      notifyListeners();
    }
  }

  getUserAndFriendsEvents() async {
    try {
      _timelineFriendsState = AppState.loading;
      notifyListeners();

      final s = await _event.getUserEvents(_user.user!.id!);
      if (s.item1 != null) {
        _userAndFriendevents.clear();
        _userAndFriendevents.addAll(s.item1?.events ?? []);
        for (var i = 0; i < s.item1!.events.length; i++) {
          final data = s.item1!.events[i];
          _userEventsCalendar.addAll({
            DateTime.parse("${data.startDate!.toIso8601String()}Z"): [data]
          });
        }

        _timelineFriendsState = AppState.success;
        notifyListeners();
      }

      _timelineFriendsState = AppState.error;
      notifyListeners();
    } catch (e) {
      _timelineFriendsState = AppState.error;
      notifyListeners();
    }
  }

  refreshUserAndFriendsEvents() async {
    try {
      final s = await _event.getUserEvents(_user.user!.id!);

      if (s.item1 != null) {
        _userAndFriendevents.clear();
        _userAndFriendevents.addAll(s.item1?.events ?? []);
        _userEventsCalendar.clear();
        for (var i = 0; i < s.item1!.events.length; i++) {
          final data = s.item1!.events[i];
          _userEventsCalendar.addAll({
            DateTime.parse("${data.startDate!.toIso8601String()}Z"): [data]
          });
        }

        notifyListeners();
      }
    } catch (_) {}
  }

  getComments(String id) async {
    try {
      final s = await _comm.getComments(id: id);
      if (s.item1 != null) {
        _comments.clear();
        _comments.addAll(s.item1 ?? []);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  refreshComments(String id) async {
    try {
      final s = await _comm.getComments(id: id);
      if (s.item1 != null) {
        _comments.clear();
        _comments.addAll(s.item1 ?? []);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  createComment(
    String id,
    CreateComment comment,
  ) async {
    try {
      final s = await _comm.createComment(
        id: id,
        body: comment,
      );
      if (s.item1 != null) {
        if (s.item1 == true) {
          await Future.delayed(const Duration(milliseconds: 200));
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> expressInterest(String id, String eventId) async {
    try {
      // bool interested = false;
      final s = await _event.expressInterest(id, eventId);
      if (s.item1 != null) {
        if (s.item1!.message == "success") {
          EventProvider.instance.refreshUserAndFriendsEvents();
          return GlobalProvider.instance.getUserEvents(id).then((_) {
            final isAvailable = GlobalProvider.instance.userEvents.where((element) => element!.id == eventId).isNotEmpty;
            return isAvailable;
          });
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteInterest(String id, String eventId) async {
    try {
      // bool interested = false;
      final s = await _event.deleteInterest(id, eventId);
      if (s.item1 != null) {
        if (s.item1!.message == "success") {
          EventProvider.instance.refreshUserAndFriendsEvents();
          return GlobalProvider.instance.getUserEvents(id).then((_) {
            final isNotAvailable = GlobalProvider.instance.userEvents.where((element) => element!.id == eventId).isEmpty;
            return isNotAvailable;
          });
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  logOut() {
    _allGroups.clear();
    _ev = null;
    _eventsCalendar.clear();
    _userEventsCalendar.clear();
    _events.clear();
    _userAndFriendevents.clear();
    _comments.clear();
    notifyListeners();
  }

  AppState get state => _state;
  AppState get timelineState => _timelineState;
  AppState get eventState => _eventState;
  AppState get getGroupState => _getGroupState;
  List<GroupDetails?> get allGroups => _allGroups;
  EventFull? get event => _ev;
  Map<DateTime, List<EventNorm>> get eventsCalendar => _eventsCalendar;
  Map<DateTime, List<EventFull>> get userEventsCalendar => _userEventsCalendar;
  List<EventNorm> get events => _events;
  List<EventFull> get personalEvent => _userAndFriendevents;
  List<Comment> get comments => _comments;
  AppState get timelineFriend => _timelineFriendsState;
}
