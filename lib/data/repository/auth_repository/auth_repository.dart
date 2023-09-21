import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hurricane_events/component/constants/error_text_default.dart';
import 'package:hurricane_events/data/api/api_implementation.dart';
import 'package:hurricane_events/data/repository/auth_repository/auth_repo_interface.dart';
import 'package:tuple/tuple.dart';

class AuthRepository extends ApiImplementation implements AuthRepositoryInterface {
  AuthRepository._();
  static final AuthRepository instance = AuthRepository._();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Tuple2<User?, String?>> googleAuth() async {
    try {
      User? user;
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
        user = _auth.currentUser;
      }

      if (user != null) {
        /// i'm returning the firebase user for now, there'll be an additional call that'll return the user id.
        /// Which we'll store and use for subsequent calls
        return Tuple2(user, "success");
      }

      return const Tuple2(null, defaultError);
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }

  @override
  Future<Tuple2<GoogleSignInAccount?, String?>> logOut() async {
    try {
      final s = await _googleSignIn.signOut();
      await _auth.signOut();
      if (s == null) {
        /// Sign out is successful if you receive a null value from the google sign in account
        return const Tuple2(null, null);
      }

      return Tuple2(s, defaultError);
    } catch (e) {
      return const Tuple2(null, defaultError);
    }
  }
}
