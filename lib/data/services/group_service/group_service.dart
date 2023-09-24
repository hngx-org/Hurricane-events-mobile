import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/models/groups/add_user.dart';
import 'package:hurricane_events/data/models/groups/create_group.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';
import 'package:hurricane_events/data/models/groups/invite_users.dart';
import 'package:retrofit/retrofit.dart';

part 'group_service.g.dart';

@RestApi(baseUrl: kDebugMode ? "https://hurricane-event-dev.onrender.com/" : "https://hurricane-event.onrender.com/")
abstract class GroupService {
  factory GroupService(Dio dio, {String baseUrl}) = _GroupService;

  @POST("/groups")
  Future<CreateGroup> createGroup({
    @Body() required Map<String, dynamic> body,
  });

  @POST("/groups/{group_id}/members/{user_id}")
  Future<AddUser> addUser({
    @Path("user_id") required String userId,
    @Path("group_id") required String groupId,
  });

  @DELETE("/groups/{group_id}/members/{user_id}")
  Future<AddUser> removeUser({
    @Path("user_id") required String userId,
    @Path("group_id") required String groupId,
  });

  @GET("/groups/users/{id}")
  Future<List<GroupDetails>> getGroupsList(
    @Path("id") String userId,
  );

  @GET("/groups")
  Future<List<GroupDetails>> getAllGroups();

  @POST("/groups/{group_id}/events/{event_id}")
  Future<AddUser> addEventToGroup({
    @Path("group_id") required String groupId,
    @Path("event_id") required String eventId,
  });

  @POST("/users/{user_id}/groups/{group_id}")
  Future<InviteUsers> inviteUsersToGroups({
    @Path("user_id") required String userId,
    @Path("group_id") required String groupId,
    @Body() required Map<String, dynamic> body,
  });

  @DELETE("/groups/{group_id}/events/{event_id}")
  Future<AddUser> deleteEventFromGroup({
    @Path("group_id") required String userId,
    @Path("event_id") required String groupId,
  });

  @GET("/groups/{id}/events")
  Future<List<EventFull?>?> getAllGroupEvents(
    @Path("id") String groupId,
  );
}
