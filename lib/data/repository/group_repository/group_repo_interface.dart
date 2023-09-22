import 'package:hurricane_events/data/models/groups/add_user.dart';
import 'package:hurricane_events/data/models/groups/create_group.dart';
import 'package:tuple/tuple.dart';

abstract class GroupRepositoryInterface {
  Future<Tuple2<CreateGroup?, String?>> createGroup({
    required String title
  });
  Future<Tuple2<AddUser?, String?>> addUser({
    required String userId,
    required String groupId,
  });

}