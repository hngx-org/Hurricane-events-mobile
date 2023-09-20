/// BEFORE DOING THIS MAKE SURE YOU'VE UNDERSTOOD THE SERVICES FILE IMPLEMENTATION
/// 
/// 
/// So after adding your new service to the services folder.
/// 
/// NOTE: DO not add a new service if your service is already present
/// if your service is not present
/// 
/// In th abstract class add your service.
/// Example
/// Previously we added TestService
/// So we add it like this
/// TestService testService() {
///     return TestService(_getDioWith(interceptors: [ApiInterceptor()]));
/// }
/// 
/// And that's all you need to do while you move to the repository folder