import 'package:flutter/material.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/data/models/events/add_events_modal.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/repository/event_repository/event_repository.dart';

class EventProvider extends ChangeNotifier {
  EventProvider._();
  static final EventProvider instance = EventProvider._();

  final _event = EventRepository.instance;

  AppState _state = AppState.init;
  AppState _timelineState = AppState.init;
  AppState _eventState = AppState.init;

  final List<EventNorm> _events = [];

  createEvent({
    required AddEventsRequest body,
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

  Future<EventFull?> getEventId({required String id}) async {
    try {
      _eventState = AppState.loading;
      notifyListeners();

      final s = await _event.getEventDetail(id);
      if (s.item1 != null) {
        await Future.delayed(const Duration(milliseconds: 200));
        _eventState = AppState.success;
        notifyListeners();

        return s.item1;
      }

      _eventState = AppState.error;
      notifyListeners();
      return null;
    } catch (e) {
      _eventState = AppState.error;
      notifyListeners();
      return null;
    }
  }

  refreshEvents() async {
    try {
      final s = await _event.getEvents();
      if (s.item1 != null) {
        _events.clear();
        _events.addAll(s.item1 ?? []);
        notifyListeners();
      }
    } catch (_) {}
  }

  getEvents() async {
    try {
      _timelineState = AppState.loading;
      notifyListeners();

      final s = await _event.getEvents();
      if (s.item1 != null) {
        _events.addAll(s.item1 ?? []);

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

  AppState get state => _state;
  AppState get timelineState => _timelineState;
  AppState get eventState => _eventState;
  List<EventNorm> get events => _events;
}
