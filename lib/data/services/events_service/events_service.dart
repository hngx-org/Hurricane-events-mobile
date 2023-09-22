import 'package:dio/dio.dart';
import 'package:hurricane_events/data/models/events/add_event_resp.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:retrofit/retrofit.dart';

part 'events_service.g.dart';

@RestApi(baseUrl: "https://hurricane-event.onrender.com/api")
abstract class EventsService {
  factory EventsService(Dio dio, {String baseUrl}) = _EventsService;

  @POST("/events")
  Future<AddEventResp> createEvents(
    @Body() Map<String, dynamic> body,
  );

  @GET("/events")
  Future<List<EventNorm>?> listEvents();

  @GET("/events/{id}")
  Future<EventFull?> getEventsDetails(@Path("id") String id);

  @PUT("/events/{id}")
  Future updateEventsDetails(@Path("id") String id);

  @DELETE("/events/{id}")
  Future deleteEventsDetails();

  @POST("/events/{id}/comments")
  Future createComment(
    @Path("id") String id,
    @Body() Map<String, dynamic> body,
  );

  @GET("/events/{id}/comments")
  Future getCommentsForEvent(@Path("id") String id);

  @POST("/comments/{id}/images")
  Future addImagesToComment(
    @Path("id") String id,
    @Body() Map<String, dynamic> body,
  );

  @GET("/comments/{id}/images")
  Future getImagesForComments(@Path("id") String id);
}
