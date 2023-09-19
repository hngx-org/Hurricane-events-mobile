/// BEFORE DOING THIS MAKE SURE YOU'VE UNDERSTOOD THE API IMPLEMENTATION.DART FILE
/// 
/// 
/// After doing the needful in the api implementation.
/// We create a repository folder if it is not yet created for the service we created.
/// 
/// So id it's not yet created 
/// Wec create test_repository
/// In this folder we create 2 files
/// test_repository_interface.dart
/// test_repository.dart
/// 
/// The interface is the file that determines what happens on the main repo.
/// In this interface we introduce Tuple
/// What is Tuple?
/// https://pub.dev/packages/tuple has more info and use case
/// Tuple is just a way to assign nullable records and value to a variable.
/// So to cap it up you don't know if what the backend is sending contains a data or not
/// So we use tuple for the assignment of these possible null values.
///
/// How does a Tuple work
/// So the backend gives you an endpoint to fetch channels
/// You're expecting a list of channels and maybe a succss bool of true to make your checks
/// That means you're expecting 2 values.
/// So you'll define the tuple with the number of expected results and their types
/// Make sure it's nullable
/// 
/// So in the test_repository_interface.dart, we have
/// 
/// abstract class TestRepositoryInteface {
///   Future<Tuple2<List<Channels>?, bool?>> getChannels()
/// }
/// 
/// Do this for the new call functions you create in services and the expected results from them.
/// it may range from 2-7, Tuple can handle it.
/// 
/// So in your test_repository.dart
/// Create a class and  extend the api implementation and implement the api repository interface
/// Like this
/// 
/// class ApiRepository extends ApiImplementation implments ApiRepositoryInterface {}
/// 
/// This should give an error about needing overrides
/// Create the overrides using your IDE helper and your getChannels function should appear 
/// 
/// If your function is needing a body or an input parameter or variable
/// abstract class TestRepositoryInteface {
///   Future<Tuple2<List<Channels>?, bool?>> getChannels('pass in variable here')
/// }
/// 
/// You can see the test example on how to structure your repository calls for error handling.
/// NOTE: Your Tuple must always leave a slot for error messages from the backend and exceptions.