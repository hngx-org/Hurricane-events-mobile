import 'package:dio/dio.dart';
import 'package:hurricane_events/component/constants/error_text_default.dart';
import 'package:hurricane_events/data/api/api_implementation.dart';
import 'package:hurricane_events/data/models/groups/create_group.dart';
import 'package:hurricane_events/data/repository/group_repository/group_repo_interface.dart';
import 'package:tuple/tuple.dart';

class GroupRepository extends ApiImplementation
    implements GroupRepositoryInterface {
  GroupRepository._();
  static final GroupRepository instance = GroupRepository._();

  @override
  Future<Tuple2<CreateGroup?, String?>> createGroup(
      {required String title}) async {
    try {
      final result = await groupService().createGroup(
        body: {"title": title},
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
}
