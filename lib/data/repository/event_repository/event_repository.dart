import 'package:dio/dio.dart';
import 'package:hurricane_events/component/constants/error_text_default.dart';
import 'package:hurricane_events/data/api/api_implementation.dart';
import 'package:hurricane_events/data/models/events/add_events_modal.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/repository/event_repository/event_repository_interface.dart';
import 'package:tuple/tuple.dart';

class EventRepository extends ApiImplementation implements EventRepositoryInterface {
  EventRepository._();
  static final EventRepository instance = EventRepository._();

  @override
  Future<Tuple2<bool?, String?>> createEvent({
    required AddEventsRequest body,
  }) async {
    try {
      final result = await eventService().createEvents(body.toJson());
      if (result.message != null) {
        if (result.message?.toLowerCase() == "success") {
          return const Tuple2(true, null);
        }

        return const Tuple2(null, defaultError);
      }

      return const Tuple2(null, defaultError);
    } on DioException catch (dio) {
      switch (dio.type) {
        case DioExceptionType.connectionTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.sendTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.receiveTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.connectionError:
          return const Tuple2(null, socketError);
        case DioExceptionType.cancel:
          return const Tuple2(null, null);
        default:
          return const Tuple2(null, defaultError);
      }
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }

  @override
  Future<Tuple2<List<EventNorm>?, String?>> getEvents() async {
    try {
      final result = await eventService().listEvents();
      if (result != null) {
        return Tuple2(result, null);
      }

      return const Tuple2(null, defaultError);
    } on DioException catch (dio) {
      switch (dio.type) {
        case DioExceptionType.connectionTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.sendTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.receiveTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.connectionError:
          return const Tuple2(null, socketError);
        case DioExceptionType.cancel:
          return const Tuple2(null, null);
        default:
          return const Tuple2(null, defaultError);
      }
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }

  @override
  Future<Tuple2<EventFull?, String?>> getEventDetail(String id) async {
    try {
      final result = await eventService().getEventsDetails(id);
      if (result != null) {
        return Tuple2(result, null);
      }

      return const Tuple2(null, defaultError);
    } on DioException catch (dio) {
      switch (dio.type) {
        case DioExceptionType.connectionTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.sendTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.receiveTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.connectionError:
          return const Tuple2(null, socketError);
        case DioExceptionType.cancel:
          return const Tuple2(null, null);
        default:
          return const Tuple2(null, defaultError);
      }
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }
  
  @override
  Future<Tuple2<bool?, String?>> deleteEvent(String id)async{
     try {
      final result = await eventService().deleteEventsDetails();
      if (result != null) {
        return Tuple2(result, null);
      }

      return const Tuple2(null, defaultError);
    } on DioException catch (dio) {
      switch (dio.type) {
        case DioExceptionType.connectionTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.sendTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.receiveTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.connectionError:
          return const Tuple2(null, socketError);
        case DioExceptionType.cancel:
          return const Tuple2(null, null);
        default:
          return const Tuple2(null, defaultError);
      }
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }
}
