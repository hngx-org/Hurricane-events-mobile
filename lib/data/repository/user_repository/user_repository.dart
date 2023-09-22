import 'package:dio/dio.dart';
import 'package:hurricane_events/component/constants/error_text_default.dart';
import 'package:hurricane_events/data/api/api_implementation.dart';
import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/models/user/user_id.dart';
import 'package:hurricane_events/data/repository/user_repository/user_repo_interface.dart';
import 'package:tuple/tuple.dart';

class UserRepository extends ApiImplementation implements UserRepositoryInterface {
  UserRepository._();
  static final UserRepository instance = UserRepository._();

  @override
  Future<Tuple2<AppUser?, String?>> getUserDetails(String id) async {
    try {
      final result = await userService().getUserDetails(id);

      assert(
        result.email != null,
        result.id != null,
      );

      if (result.id != null) {
        return Tuple2(result, null);
      }

      return const Tuple2(null, defaultError);
    } on DioException catch (dio) {
      switch (dio.type) {
        case DioExceptionType.connectionTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.sendTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.receiveTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.connectionError:
          return const Tuple2(null, socketError);
        case DioExceptionType.cancel:
          return const Tuple2(null, null);
        default:
          return const Tuple2(null, defaultError);
      }
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }

  @override
  Future<Tuple2<UserId?, String?>> createUser({
    required String email,
    required String name,
    required String avatar,
  }) async {
    try {
      final result = await userService().createUser(
        body: {
          "email": email,
          "name": name,
          "avatar": avatar,
        },
      );

      if (result.userId != null) {
        return Tuple2(result, null);
      }

      return const Tuple2(null, defaultError);
    } on DioException catch (dio) {
      switch (dio.type) {
        case DioExceptionType.connectionTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.sendTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.receiveTimeout:
          return const Tuple2(null, timeoutError);
        case DioExceptionType.connectionError:
          return const Tuple2(null, socketError);
        case DioExceptionType.cancel:
          return const Tuple2(null, null);
        default:
          return const Tuple2(null, defaultError);
      }
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }
}
