import 'package:dio/dio.dart';
import 'package:hurricane_events/data/models/comments/comment.dart';
import 'package:hurricane_events/data/models/events/event_interest.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/models/groups/events_create.dart';
import 'package:hurricane_events/data/models/message_response.dart';
import 'package:retrofit/retrofit.dart';

part 'events_service.g.dart';

@RestApi()
abstract class EventsService {
  factory EventsService(Dio dio, {String baseUrl}) = _EventsService;

  @POST("/events")
  Future<CreateEvent> createEvents(
    @Body() Map<String, dynamic> body,
  );

  @GET("/events")
  Future<List<EventNorm>?> listEvents();

  @GET("/events/{id}")
  Future<EventFull?> getEventsDetails(@Path("id") String id);

  @PUT("/events/{id}")
  Future updateEventsDetails(@Path("id") String id);

  @DELETE("/events/{id}")
  Future<MessageResponse> deleteEventsDetails(@Path("id") String id);

  @POST("/events/{id}/comments")
  Future<MessageResponse> createComment(
    @Path("id") String id,
    @Body() Map<String, dynamic> body,
  );

  @GET("/events/{id}/comments")
  Future<List<Comment>?> getCommentsForEvent(@Path("id") String id);

  @POST("/comments/{id}/images")
  Future addImagesToComment(
    @Path("id") String id,
    @Body() Map<String, dynamic> body,
  );

  @POST("/groups/{group_id}/events/{event_id}")
  Future<MessageResponse> addEventsToGroup(
    @Path("group_id") String groupId,
    @Path("event_id") String eventId,
  );

  @GET("/comments/{id}/images")
  Future getImagesForComments(@Path("id") String id);

  @POST("/users/{user_id}/interests/{event_id}")
  Future<MessageResponse> expressInterestInEvent(@Path("user_id") String id, @Path("event_id") String eventId);

  @DELETE("/users/{user_id}/interests/{event_id}")
  Future<MessageResponse> deleteInterestInEvent(@Path("user_id") String id, @Path("event_id") String eventId);

  @GET("/events/{user_id}/events")
  Future<EventInterestResponse?> getUserEvents(@Path('user_id') String id);
}
