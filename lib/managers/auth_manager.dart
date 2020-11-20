import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._privateConstructor();
  factory AuthManager() {
    return _instance;
  }
  AuthManager._privateConstructor();

  final _auth = FirebaseAuth.instance;

  Future<UserCredential> createUser(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final existingUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return existingUser;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
