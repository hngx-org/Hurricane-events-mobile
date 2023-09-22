import 'package:hurricane_events/data/models/groups/create_group.dart';
import 'package:tuple/tuple.dart';

abstract class GroupRepositoryInterface {
  Future<Tuple2<CreateGroup?, String?>> createGroup({
    required String title
  });

}
