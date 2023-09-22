import 'package:dio/dio.dart';
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

}
