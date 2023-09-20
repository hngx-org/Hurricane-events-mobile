/// This is your first stop when you want to start an api implementation.
/// The data part is divided into 3
/// Ap1, Repository, Models, Services.
/// 
/// To start or initiate a network call.
/// First check if the service you want to implement under has been created yet.
/// If it hasnt been created, Create a new service folder then inside create a file
/// lets say test_service.dart
/// 
/// 1)first things first is to create an abstract class of that test you want to create
/// abstract class TestService {}
/// 
/// 2)Second add a factory constructor on the abstract class.
/// Add dio as one of the parameters to take in and a baseUrl,
/// abstract class TestService {
///   factory TestService(Dio dio, {String baseUrl}) = _TestService;  
/// }
/// 
/// 3)Don't worry if you're getting errors here it's normal to get errors in this stage of the code.
/// Thirdly add the path to the generated file using (part) and the refrofit service wrapper api.
/// recall the name of the file you created is test_service.dart
/// 
/// 
///  part 'test_service.g.dart'
///  @RestApi(baseUrl: 'https://test.com/api/v1/')
///  abstract class TestService {
///   factory TestService(Dio dio, {String baseUrl}) = _TestService;  
/// }
/// 
/// This above is how your code should look at this point in time.
/// Dont worry if there are errors in the code it's fine.
/// 
/// 4) Add all the methods you want to add to the endpoint call.
/// This is how your code should look before you add anything
/// 
/// 
///  part 'test_service.g.dart'
///  @RestApi(baseUrl: 'https://test.com/api/v1/')
///  abstract class TestService {
///   factory TestService(Dio dio, {String baseUrl}) = _TestService;  
/// }
/// 
/// Then you start adding
///  part 'test_service.g.dart'
///  @RestApi(baseUrl: 'https://test.com/api/v1/')
///  abstract class TestService {
///   factory TestService(Dio dio, {String baseUrl}) = _TestService;  
/// 
///   @GET("channels/")
///   Future getChannels();  //! This is how a normal get call look like
/// 
///    @GET("channels/{id}")
///   Future getChannels(
///     @Path('id') String/int/dynamic id   -- This line of code tells you your input type, it can be a string, int or any other type, it can only be one at a time and not multiple like I depicted here.
///   );  //! This is how a get call with query path looks like
/// 
///    @GET("channels/")
///   Future getChannels(
///     @Query("query_name") String id -- this will give the endpoint as http://test.com/api/v1/channels?query_name=id
///   );  //! This is how a get call with query params look like
/// 
///   @POST("channels/")
///   Future getChannels(
///     @Body() Map<String, dynamic> input
///   );  //! This is how a call with body look like
/// }
/// 
/// Now after adding the calls you need and want to add,
/// Run flutter pub run build_runner build --delete-conflicting-outputs
/// This will automatically generate your http calls code for you and should get rid of your errors.
/// 
/// If you are still getting erros, review this read me again or reach out to your team members.
/// After getting this the next step is to add the service to your api implementation.
/// So go to data/api you'll find api implementation there
/// 
/// You can read the read me file for context.