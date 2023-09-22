import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/models/user/user_id.dart';
import 'package:tuple/tuple.dart';

abstract class UserRepositoryInterface {
  Future<UserId> createUser(
      {required String email, required String name, required String avatar});
  Future<Tuple2<AppUser?, String?>> getUserDetails(String id);
}
