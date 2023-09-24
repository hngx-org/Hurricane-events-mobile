import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/data/models/groups/add_user.dart';
import 'package:hurricane_events/data/models/groups/create_group.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';
import 'package:hurricane_events/data/models/groups/invite_users.dart';
import 'package:tuple/tuple.dart';

abstract class GroupRepositoryInterface {
  Future<Tuple2<CreateGroup?, String?>> createGroup({
    required String title,
    required String id,
    String? avatar,
  });
  Future<Tuple2<AddUser?, String?>> addUser({
    required String userId,
    required String groupId,
  });
  Future<Tuple2<AddUser?, String?>> removeUser({
    required String userId,
    required String groupId,
  });

  Future<Tuple2<AddUser?, String?>> deleteGroup({
    required String groupId,
  });

  Future<Tuple2<List<GroupDetails?>?, String?>> getGroupsList(String id);
  Future<Tuple2<List<GroupDetails?>?, String?>> getAllGroups();
  Future<Tuple2<List<GroupDetails?>?, String?>> getUserGroups(String id);

  Future<Tuple2<List<EventFull?>?, String?>> getAllGroupEvents(String id);
  Future<Tuple2<InviteUsers?, String?>> inviteUsersToGroup(
    String userId,
    String groupId,
    List<String> list,
  );

  Future<Tuple2<AddUser?, String?>> addEventToGroup(String group, String event);
}
