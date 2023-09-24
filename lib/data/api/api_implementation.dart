import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hurricane_events/data/api/api_interceptor.dart';
import 'package:hurricane_events/data/services/events_service/events_service.dart';
import 'package:hurricane_events/data/services/group_service/group_service.dart';
import 'package:hurricane_events/data/services/test_service/test_service.dart';
import 'package:hurricane_events/data/services/user_service/user_service.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

abstract class ApiImplementation {
  final BaseOptions _options = BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
    followRedirects: true,
  );
  Dio _instance() {
    final dio = Dio(_options)
      ..interceptors.add(
        kDebugMode
            ? TalkerDioLogger(
                settings: const TalkerDioLoggerSettings(
                  printResponseData: true,
                  printRequestData: true,
                  printResponseMessage: true,
                  printRequestHeaders: false,
                  printResponseHeaders: false,
                ),
              )
            : Dummy(),
      );
    return dio;
  }

  Dio _getDioWith({required List<Interceptor> interceptors}) {
    return _instance()..interceptors.addAll(interceptors);
  }

  TestService testService() {
    return TestService(_getDioWith(interceptors: [ApiInterceptor()]));
  }

  UserService userService() {
    return UserService(_getDioWith(interceptors: [ApiInterceptor()]),
        baseUrl:
            // kDebugMode ? "https://hurricane-event-dev.onrender.com/api" :
            "https://hurricane-event.onrender.com/api");
  }

  GroupService groupService() {
    return GroupService(_getDioWith(interceptors: [ApiInterceptor()]),
        baseUrl:
            //  kDebugMode ? "https://hurricane-event-dev.onrender.com/api" :
            "https://hurricane-event.onrender.com/api");
  }

  EventsService eventService() {
    return EventsService(
      _getDioWith(interceptors: [ApiInterceptor()]),
      baseUrl:
          //  kDebugMode ? "https://hurricane-event-dev.onrender.com/api" :
          "https://hurricane-event.onrender.com/api",
    );
  }
}
