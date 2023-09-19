import 'package:dio/dio.dart';
import 'package:hurricane_events/component/constants/error_text_default.dart';
import 'package:hurricane_events/data/api/api_implementation.dart';
import 'package:hurricane_events/data/repository/test_repo/test_repo_interface.dart';
import 'package:tuple/tuple.dart';

class TestRepo extends ApiImplementation implements TestRepoInterface {
  @override
  Future<Tuple2<List<Channels>?, String?>> getChannels() async {
    try {
      final result = await testService().getGoogle();

      if (result.data != null) {
        return Tuple2(
          List<Channels>.from(result.data),
          "Success",
        );
      } else {
        return Tuple2(null, result.error ?? defaultError);
      }
    } on DioException catch (dio) {
      switch (dio.type) {
        //This is thrown when the call duration is taking too long due to bad network
        case DioExceptionType.connectionTimeout:
          return const Tuple2(null, timeoutError);
        //This is thrown when the call duration is taking too long due to bad network
        case DioExceptionType.sendTimeout:
          return const Tuple2(null, timeoutError);
        //This is thrown when the call duration is taking too long due to bad network
        case DioExceptionType.receiveTimeout:
          return const Tuple2(null, timeoutError);
        //This is thrown when there is no internet connection on device
        case DioExceptionType.connectionError:
          return const Tuple2(null, socketError);
        //This is thrown when a cancel token is used
        case DioExceptionType.cancel:
          return const Tuple2(null, null);
        default:
          //This is the default callback
          return const Tuple2(null, defaultError);
      }
    } catch (e) {
      //This is the default callback
      return const Tuple2(null, defaultError);
    }
  }
}
