import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'test_service.g.dart';

@RestApi(baseUrl: "https://google.com")
abstract class TestService {
  factory TestService(Dio dio, {String baseUrl}) = _TestService;

  @POST("")
  Future postGoogle();

  @GET("")
  Future getGoogle();

  @PUT("")
  Future putGoogle();

  @PATCH("")
  Future patchGoogle();

  @DELETE("")
  Future deleteGoogle();
}
