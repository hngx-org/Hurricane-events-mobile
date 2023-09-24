import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/models/user/user_id.dart';
import 'package:tuple/tuple.dart';

abstract class UserRepositoryInterface {
  Future<Tuple2<UserId?, String?>> createUser({
    required String email,
    required String name,
    required String avatar,
    required String token,
  });

  Future<Tuple2<AppUser?, String?>> getUserDetails(String id);
}
