import 'package:flutter/material.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/repository/event_repository/event_repository.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider._();
  static GlobalProvider instance = GlobalProvider._();

  final _event = EventRepository.instance;

  List<EventFull?> _userEvents = [];

  Future getUserEvents(String userId) async {
    final res = await _event.getUserEvents(userId);
    if (res.item1 != null) {
      _userEvents.clear();
      _userEvents = res.item1!.events;
      notifyListeners();
    }
  }

  List<EventFull?> get userEvents => _userEvents;
}
