import 'package:dio/dio.dart';
import 'package:hurricane_events/component/constants/error_text_default.dart';
import 'package:hurricane_events/data/api/api_implementation.dart';
import 'package:hurricane_events/data/models/comments/comment.dart';
import 'package:hurricane_events/data/models/comments/create_comments.dart';
import 'package:hurricane_events/data/repository/comment_repositpory/comments_repo_interface.dart';
import 'package:tuple/tuple.dart';

class CommentsRepository extends ApiImplementation implements CommentsRepositoryInterface {
  CommentsRepository._();
  static final CommentsRepository instance = CommentsRepository._();

  @override
  Future<Tuple2<bool?, String?>> createComment({
    required String id,
    required CreateComment body,
  }) async {
    try {
      final result = await eventService().createComment(
        id,
        body.toJson(),
      );
      if (result.message != null) {
        if (result.message?.toLowerCase() == "success") {
          return const Tuple2(true, null);
        }

        return const Tuple2(null, defaultError);
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
  Future<Tuple2<List<Comment>?, String?>> getComments({
    required String id,
  }) async {
    try {
      final result = await eventService().getCommentsForEvent(id);
      if (result != null) {
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
