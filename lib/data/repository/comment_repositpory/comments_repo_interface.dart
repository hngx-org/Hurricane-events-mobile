import 'package:hurricane_events/data/models/comments/comment.dart';
import 'package:hurricane_events/data/models/comments/create_comments.dart';
import 'package:tuple/tuple.dart';

abstract class CommentsRepositoryInterface {
  Future<Tuple2<bool?, String?>> createComment({
    required String id,
    required CreateComment body,
  });

  Future<Tuple2<List<Comment>?, String?>> getComments({
    required String id,
  });
}
