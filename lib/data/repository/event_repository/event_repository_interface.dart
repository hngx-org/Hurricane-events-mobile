import 'package:hurricane_events/data/models/events/add_events_modal.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:tuple/tuple.dart';

abstract class EventRepositoryInterface {
  Future<Tuple2<bool?, String?>> createEvent({
    required AddEventsRequest body,
  });

  Future<Tuple2<List<EventNorm>?, String?>> getEvents();

  Future<Tuple2<EventFull?, String?>> getEventDetail(String id);

  Future<Tuple2<bool?, String?>> deleteEvent(String id);
}
