import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFormFirebaseUser(User? user) {
    return user;
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      final User? user = authResult.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;

      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new app member', 100);

      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = authResult.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
