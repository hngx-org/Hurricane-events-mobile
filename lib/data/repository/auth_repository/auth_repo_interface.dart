import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tuple/tuple.dart';

abstract class AuthRepositoryInterface {
  Future<Tuple2<User?, String?>> googleAuth();

  Future<Tuple2<GoogleSignInAccount?, String?>> logOut();
}
