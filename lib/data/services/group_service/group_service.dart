import 'package:dio/dio.dart';
import 'package:hurricane_events/data/models/groups/add_user.dart';
import 'package:hurricane_events/data/models/groups/create_group.dart';
import 'package:retrofit/retrofit.dart';

part 'group_service.g.dart';

@RestApi(baseUrl: "https://hurricane-event.onrender.com/api")
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
}
