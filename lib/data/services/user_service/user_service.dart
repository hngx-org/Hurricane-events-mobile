import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/models/user/user_id.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: kDebugMode ? "https://hurricane-event-dev.onrender.com/" : "https://hurricane-event.onrender.com/")
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @POST("/auth")
  Future<UserId> createUser({
    @Body() required Map<String, dynamic> body,
  });

  @GET("/users/{user_id}")
  Future<AppUser> getUserDetails(@Path("user_id") String id);
}
