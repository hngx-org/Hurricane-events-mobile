import 'package:hurricane_events/data/api/api_implementation.dart';
import 'package:hurricane_events/data/models/user/user.dart';
import 'package:hurricane_events/data/models/user/user_id.dart';
import 'package:hurricane_events/data/repository/user_repository/user_repo_interface.dart';
import 'package:tuple/tuple.dart';

class UserRepository extends ApiImplementation
    implements UserRepositoryInterface {
  UserRepository._();
  static final UserRepository instance = UserRepository._();

  @override
  Future<Tuple2<AppUser?, String?>> getUserDetails(String id) async {
    return userService().getUserDetails(id).then((value) {
      return Tuple2(value, null);
    });
  }

  @override
  Future<UserId> createUser(
      {required String email,
      required String name,
      required String avatar}) async {
    final result = await userService()
        .createUser(body: {"email": email, "name": name, "avatar": avatar});
    return result;
  }
}
